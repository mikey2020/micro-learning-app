require 'sinatra/activerecord'
require_relative './user.rb'
require_relative './user_category.rb'

class Category < ActiveRecord::Base
  has_many :user_catgeories
  has_many :pages
  has_many :users, through: :user_catgeories
end
  