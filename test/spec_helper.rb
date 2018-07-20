require 'rack/test'
require 'rspec'
require 'coveralls'
require 'simplecov'
require 'simplecov-console'
require 'factory_bot'
require 'shoulda-matchers'

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods

  def app
    described_class
  end
end

RSpec.configure do |c|
  c.include RSpecMixin
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  FactoryBot.find_definitions
end

RSpec.configure do |config|
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
end

Coveralls.wear!
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [
    SimpleCov::Formatter::Console,
    # Want a nice code coverage website? Uncomment this next line!
    SimpleCov::Formatter::HTMLFormatter,
  ]
)
SimpleCov.start
