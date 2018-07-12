require 'sinatra/activerecord'
require_relative './category.rb'
require_relative './user.rb'

# UserCategory model
class UserCategory < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
end
