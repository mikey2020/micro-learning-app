require 'sinatra/activerecord'
require_relative './category.rb'

# Page model
class Page < ActiveRecord::Base
  belongs_to :category
end

