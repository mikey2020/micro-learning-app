require 'sinatra/activerecord'

# User model
class User < ActiveRecord::Base
  has_many :pages, dependent: :destroy
  has_many :user_categories
  has_many :categories, through: :user_categories

  has_secure_password
  validates :username, uniqueness: true, presence: true
  validates :password,
            length: { minimum: 5 },
            format: {
              with: /\A^(?=.*\d)(?=.*[a-zA-Z])[a-zA-Z\d]{5,50}\z/,
              message: 'must be an alphanumeric'
            },
            on: :create
  validates :email,
            uniqueness: true,
            format: {
              with: /\A[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/,
              message: 'must be valid'
            }
end
