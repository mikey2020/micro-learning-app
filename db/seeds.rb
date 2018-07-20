require 'dotenv/load'
require 'news-api'

require_relative '../models/category.rb'
require_relative '../models/user.rb'

newsapi = News.new(ENV['API_KEY'])

sources = newsapi.get_sources(country: 'us', language: 'en')

@categories = []
sources.each do |source|
  @categories.push(source.category)
end

@categories.uniq.each do |category|
  Category.create(name: category)
end

User.create(
  username: 'admin',
  email: 'admin@gmail.com',
  password: 'admin123',
  is_admin: true
)
