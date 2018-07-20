require_relative '../spec_helper.rb'
require_relative '../../app.rb'
require_relative '../../models/user.rb'
require_relative '../../models/page.rb'

RSpec.describe User, type: :model do
  before(:each) do
    Page.delete_all
    User.delete_all
  end

  let!(:user) { create(:user) }

  it { should validate_presence_of(:username) }

  it { should have_secure_password }

  it { should validate_uniqueness_of(:username) }

  it { should validate_uniqueness_of(:email) }

  it do
    should allow_value('test@gmail.com').
      for(:email).
      with_message('must be valid')
  end

  it do
    should validate_length_of(:password).
      is_at_least(5).
      on(:create)
  end

  it do
    should allow_value('test1234').
      for(:password).
      on(:create)
  end

  it { should have_many(:pages) }

  it { should have_many(:categories).through(:user_categories) }

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
