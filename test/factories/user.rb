require 'factory_bot'
require_relative '../../models/user.rb'

# This will guess the User class
FactoryBot.define do
  factory :user do
    username 'boruto'
    email 'boruto@konoha.com'
    password 'boruto123'
  end

  # This will use the User class (Admin would have been guessed)
  factory :admin, class: User do
    username 'admin'
    email 'admin@email.com'
    password 'admin123'
    is_admin true
  end
end
