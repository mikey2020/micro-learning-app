require_relative '../spec_helper.rb'
require_relative '../../app.rb'

require_relative '../../models/page.rb'


RSpec.describe Category, :type => :model do
  it "is valid with valid attributes" do
    expect(Page.new).to be_valid
  end
end