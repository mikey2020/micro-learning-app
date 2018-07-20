require_relative '../spec_helper.rb'
require_relative '../../models/category.rb'

RSpec.describe Category, type: :model do
  it { should have_many(:users).through(:user_categories) }

  it 'is valid with valid attributes' do
    expect(Category.new).to be_valid
  end
end
