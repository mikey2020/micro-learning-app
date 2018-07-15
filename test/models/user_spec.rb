require_relative '../spec_helper.rb'
require_relative '../../app.rb'

require_relative '../../models/user.rb'

RSpec.describe User, :type => :model do

  before(:context) do
    Page.delete_all
    User.delete_all
  end

  it "is valid with valid attributes" do
    user = User.create(
        { 
            username: "boruto", 
            email: "boruto@konoha.com", 
            password: "uzumaki123",

        }
    )

    expect(user).to be_valid
    expect(user.username).to eq('boruto')
  end
end