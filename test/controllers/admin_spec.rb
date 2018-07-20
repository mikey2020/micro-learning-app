require_relative '../spec_helper.rb'
require_relative '../../app.rb'
require_relative '../../models/user.rb'
require_relative '../../models/page.rb'

RSpec.describe App do
  before(:context) do
    Page.delete_all
    User.delete_all
  end

  let(:user) do
    User.create(
      username: 'sasuke',
      email: 'sasuke@uchiha.com',
      password: 'uchiha123',
      is_admin: true
    )
  end

  it 'displays admin login page' do
    get '/admin/login'

    expect(last_response).to be_ok
    expect(last_response.status).to eq(200)

    expect(last_response.body).to include('Admin Log in')
  end

  it 'authorises valid admin user' do
    post '/admin/login', params = {
      admin: {
        username: user.username,
        password: user.password,
      },
    }
    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_response).to be_ok
    expect(last_response.status).to eq(200)

    expect(last_response.body).to include('Admin Dashboard')
    expect(last_response.body).to include('No users registered yet')
  end

  it 'displays admin dashboard page' do
    user = User.all[0]
    get '/admin/dashboard', {}, 'rack.session' => { user_id: user.id, admin: true }

    expect(last_response).to be_ok
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Admin Dashboard')
  end

  it 'displays error message for invalid user' do
    post '/admin/login', params = {
      admin: {
        username: '',
        password: '',
      },
    }

    expect(last_response).to be_ok
    expect(last_response.body).to include('You are not authorised to view this page')
  end

  it 'allows admin delete user' do
    user = User.new(
      username: 'madara',
      email: 'madara@uchiha.com',
      password: 'uchiha123'
    )
    user.save

    get "/delete/#{user.id}"

    expect(last_response).to be_ok
  end

  after(:context) do
    Page.delete_all
    User.delete_all
  end
end
