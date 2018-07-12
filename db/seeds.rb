require 'dotenv/load'
require 'news-api'

require_relative '../models/category.rb'

newsapi = News.new(ENV['API_KEY'])

sources = newsapi.get_sources(country: 'us', language: 'en')

@categories = []
sources.each do |source|
  @categories.push(source.category)
end

@categories.uniq.each do |category|
  Category.create(name: category)
end