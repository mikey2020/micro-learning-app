require_relative '../spec_helper.rb'
require_relative '../../app.rb'

require_relative '../../models/page.rb'


RSpec.describe Page, :type => :model do
  it "is valid with valid attributes" do
    page = Page.new({
      name: 'test-page',
      url: 'test-page-url'
    })
    page.save
    expect(page).to be_valid
  end
end