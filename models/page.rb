require 'sinatra/activerecord'
require_relative './category.rb'

# Page model
class Page < ActiveRecord::Base
  belongs_to :user

  validates :name, uniqueness: true, presence: true
  validates :url, uniqueness: true, presence: true
  
end

