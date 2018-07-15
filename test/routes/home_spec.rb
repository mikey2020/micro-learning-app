require_relative '../spec_helper.rb'
require_relative '../../app.rb'
require_relative '../../models/user.rb'

RSpec.describe App  do

  before(:context) do 
    @user = User.create({ username: "naruto", email: "naruto@gmail.com", password: "naruto123" })
    UserCategory.create({ user_id: @user.id, category_id: 1 })
  end

  it 'should display user"s page for the day' do
    get '/home', {}, { 'rack.session' => { user_id: @user.id } }

    expect(last_response.body).to include('Logout')
  end

  after(:context) do
    Page.delete_all
    User.delete_all
  end

end
