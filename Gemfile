# Gemfile
source 'https://rubygems.org'

gem 'bcrypt'
gem 'dotenv'
gem 'pg'
gem 'news-api'
gem 'rake'
gem 'sass'
gem 'sinatra'   
gem 'sinatra-activerecord'
gem 'sysrandom'
gem 'time_diff'
gem 'sidekiq'
gem 'pony'
gem 'sidekiq-scheduler'

group :development do
    gem 'pry'
    gem 'rubocop', '~> 0.58.1', require: false
    gem 'shotgun'
end

group :test, :development do
    gem 'rack-test', require: 'rack/test'
    gem 'rspec'
    gem 'sqlite3'
end