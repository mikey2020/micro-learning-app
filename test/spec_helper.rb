require 'rack/test'
require 'rspec'
require 'coveralls'
require 'simplecov'
require 'simplecov-console'
require 'factory_bot'

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
  # config.before(:suite) do

  # end
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
