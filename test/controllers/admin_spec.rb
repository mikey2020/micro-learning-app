require_relative '../spec_helper.rb'
require_relative '../../app.rb'
require_relative '../../models/user.rb'
require_relative '../../models/page.rb'

RSpec.describe App do
  before(:context) do
    Page.delete_all
    User.delete_all
    @user = User.new(
      username: 'sasuke', 
      email: 'sasuke@uchiha.com', 
      password: 'uchiha123', 
      is_admin: true
    )
    @user.save
  end

  it 'should display admin login page' do
    get '/admin/login'
    
    expect(last_response).to be_ok
    expect(last_response.status).to eq(200)
    
    expect(last_response.body).to include('Admin Log in')
  end

  it 'should authorise valid admin user' do
    post '/admin/login', params = { admin: { username: 'sasuke', password: 'uchiha123' } }
    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_response).to be_ok
    expect(last_response.status).to eq(200)

    expect(last_response.body).to include('Admin Dashboard')
    expect(last_response.body).to include('No users registered yet')
  end

  it 'should display admin dashboard page' do
    get '/admin/dashboard', {}, 'rack.session' => { admin_id: @user.id }

    expect(last_response).to be_ok
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Admin Dashboard')
  end

  it 'should display error message for invalid user' do
    post '/admin/login', params = { admin: { username: '', password: '' } }

    expect(last_response).to be_ok
    expect(last_response.body).to include('You are not authorised to view this page')
  end

  it 'should allow admin delete user' do
    @another_user = User.new({ username: 'madara', email: 'madara@uchiha.com', password: 'uchiha123' })
    @another_user.save

    get "/delete/#{@another_user.id}"
  

    expect(last_response).to be_ok
  end


  after(:context) do
    Page.delete_all
    User.delete_all
  end
end
