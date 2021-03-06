require_relative '../spec_helper.rb'
require_relative '../../app.rb'
require_relative '../../models/user.rb'

RSpec.describe App  do

  before(:context) do
    Page.delete_all
    User.delete_all
    @user = User.new({ username: "sasuke", email: "sasuke@uchiha.com", password: "uchiha123" })
    @user.save
  end

  it 'should display select categories page with all categories' do
    get '/categories', {}, { 'rack.session' => { user_id: @user.id } }

    expect(last_response.body).to include("Customize your learning")
    expect(last_response.body).to include("general")
    expect(last_response.body).to include("technology")
    expect(last_response.body).to include("sports")
    expect(last_response.body).to include("business")
    expect(last_response.body).to include("science")
  end

  it 'should display select categories page with all categories' do
    post '/categories', params={
      categories: [
        'general',
        'business'
      ]
    }, { 'rack.session' => { user_id: @user.id } }
    
    
    expect(last_response).to be_redirect
    follow_redirect!

    expect(last_response).to be_ok
  end

  after(:context) do
    Page.delete_all
    User.delete_all
  end

end
