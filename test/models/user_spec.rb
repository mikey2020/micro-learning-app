require_relative '../spec_helper.rb'
require_relative '../../app.rb'

require_relative '../../models/user.rb'

RSpec.describe User do
  before(:context) do
    Page.delete_all
    User.delete_all
  end

  it 'is valid with valid attributes' do
    user = User.create(
      username: 'boruto',
      email: 'boruto@konoha.com',
      password: 'uzumaki123'
    )

    expect(user).to be_valid
    expect(user.username).to eq('boruto')
    expect(user.email).to eq('boruto@konoha.com')
    expect(user.is_admin).to eq(false)
  end
end
