current_dir = Dir.pwd
Dir["#{current_dir}/models/*.rb"].each { |file| require file }
require 'dotenv/load'
require 'news-api'

newsapi = News.new(ENV['API_KEY'])


sources = newsapi.get_sources(country: 'us', language: 'en')

@categories = []
sources.each do |source|
  @categories.push(source.category)
end

@categories.uniq.each do |category|
    Category.create(name: category)
end