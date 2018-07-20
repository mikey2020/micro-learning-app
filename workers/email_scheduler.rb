require 'dotenv/load'
require 'sidekiq'
require 'sidekiq-scheduler'

require_relative '../helpers/send_email.rb'
require_relative '../helpers/get_page.rb'
require_relative '../models/user.rb'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end

Sidekiq.configure_client do |config|
  config.redis = { size: 3 }
end

ActiveRecord::Base.establish_connection(
  ENV['DATABASE_URL']
)

class SendEmail
  include Sidekiq::Worker
  def perform
    User.all.each do |user|
      unless user.is_admin?
        page = get_new_page(user)
        send_email(user.email, page)
      end
    end
  end
end