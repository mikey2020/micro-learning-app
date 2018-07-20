require_relative '../spec_helper.rb'
require_relative '../../app.rb'
require_relative '../../models/user.rb'
require_relative '../../models/page.rb'

RSpec.describe User do
  before(:each) do
    Page.delete_all
    User.delete_all
  end

  let!(:user) { create(:user) }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
    expect(user.username).to eq('boruto')
    expect(user.email).to eq('boruto@konoha.com')
    expect(user.is_admin).to eq(false)
  end

  it 'has pages' do
    Page.create(
      name: 'test-page',
      description: 'this is a test page',
      url: 'test-page-url',
      urlToImage: '',
      user_id: user.id
    )

    expect(user.pages.size).to eq(1)
    expect(user.pages[0].name).to eq('test-page')
    expect(user.pages[0].url).to eq('test-page-url')
    expect(user.pages[0].description).to eq('this is a test page')
  end

  it 'has categories' do
    UserCategory.create(user_id: user.id, category_id: 1)

    expect(user.categories.size).to eq(1)
    expect(user.categories[0].name).to eq('general')
  end
end
