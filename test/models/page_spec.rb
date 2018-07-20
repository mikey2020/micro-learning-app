require_relative '../spec_helper.rb'
require_relative '../../models/page.rb'

RSpec.describe Page, type: :model do
  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:url) }

  it { should belong_to(:user) }

  it 'is valid with valid attributes' do
    page = Page.new(
      name: 'test-page',
      url: 'test-page-url'
    )
    page.save
    expect(page).to be_valid
  end
end
 