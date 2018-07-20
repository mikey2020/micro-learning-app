require_relative '../spec_helper.rb'
require_relative '../../app.rb'
require_relative '../../models/user_category.rb'

RSpec.describe UserCategory, type: :model do

  it { should belong_to(:user) }

  it { should belong_to(:category) }

  it 'is valid with valid attributes' do
    user_category = UserCategory.new(
      category_id: 1,
      user_id: 1
    )
    user_category.save
    expect(user_category).to be_valid
  end
end
