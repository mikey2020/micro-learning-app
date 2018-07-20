require 'sidekiq'
require 'dotenv/load'
require 'pony'


def send_email(recipient, page)
  Pony.mail({
  :to => recipient,
  :via => :smtp,
  :html_body => "<h1>#{page.url}</h1>",
  :via_options => {
      :address        => 'smtp.gmail.com',
      :port           => '587',
      :user_name      => ENV['EMAIL_USER'],
      :password       => ENV['EMAIL_PASSWORD'],
      :authentication => :plain,
      :domain         => "localhost.localdomain"
  }
  })
end