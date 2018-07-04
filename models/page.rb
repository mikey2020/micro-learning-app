require 'sinatra/activerecord'
require_relative './category.rb'


class Page < ActiveRecord::Base
    belongs_to :category
end


