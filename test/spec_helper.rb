require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

# ActiveRecord::Migration.maintain_test_schema!

module RSpecMixin
  include Rack::Test::Methods

  def app
    described_class
  end
end

RSpec.configure do |c|
  c.include RSpecMixin
end
