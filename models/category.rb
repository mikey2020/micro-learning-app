require 'sinatra/activerecord'
require_relative './user.rb'
require_relative './user_category.rb'

# Category
class Category < ActiveRecord::Base
  has_many :user_categories
  has_many :users, through: :user_categories
end
