require_relative '../spec_helper.rb'
require_relative '../../app.rb'
require_relative '../../models/user.rb'
require_relative '../../models/user_category.rb'

RSpec.describe App  do

  before(:context) do
    Page.delete_all
    User.delete_all
    UserCategory.delete_all
  end

  it 'should add user user to the database' do
    post '/user/signup', params={ user: { username: 'naruto', email: 'naruto@email.com', password: 'tester123' } }

    expect(last_response).to be_redirect
    follow_redirect!

    expect(last_response).to be_ok
    expect(last_response.body).to include('Customize your learning')
  end

  it 'should display user sign up page' do
    get '/user/signup'
    expect(last_response).to be_ok
    expect(last_response.body).to include('username')
    expect(last_response.body).to include('email')
    expect(last_response.body).to include('password')
  end
  
  it 'should display error message when username is empty' do
    post '/user/signup', params={ user: { username: '  ', email: 'naruto@email.com', password: 'tester123' } }
    
    expect(last_response).to be_ok
    expect(last_response.body).to include("username can't be blank")
  end

  it 'should display error message when password is not alphanumeric' do
    post '/user/signup', params={ user: { username: 'test', email: 'test@email.com', password: 'tester' } }

    expect(last_response).to be_ok
    expect(last_response.body).to include('password must be an alphanumeric')
  end

  it 'should display error message when password is empty' do
    post '/user/signup', params={ user: { username: 'test', email: 'test@email.com', password: ''} }
    
    expect(last_response).to be_ok
    expect(last_response.body).to include("password can't be blank")
  end

  it 'should display error message when email is empty' do
    post '/user/signup', params={ user: { username: 'test', email: '', password: 'tester123' } }
    
    expect(last_response).to be_ok
    expect(last_response.body).to include('email must be valid')
  end

  it 'should display user login page' do
    get '/user/login'
    expect(last_response).to be_ok
    expect(last_response.body).to include('username')
    expect(last_response.body).to include('password')
  end

  it 'should login user' do
    post '/user/login', params={ user: { username: 'naruto', password: 'tester123' } } 

    expect(last_response).to be_redirect
    follow_redirect!

    expect(last_response).to be_redirect
    follow_redirect!
  
    expect(last_response).to be_ok
    expect(last_response.body).to include('Customize your learning')
  end

  it 'should display error message when username is empty' do
    post '/user/login', params={ user: { username: '  ', password: 'tester123' } }
    
    expect(last_response).to be_ok
    expect(last_response.body).to include('Invalid username or password')
  end

  it 'should display error message when password is empty' do
    post '/user/login', params={ user: { username: 'tester', password: '' } }
    
    expect(last_response).to be_ok
    expect(last_response.body).to include('Invalid username or password')
  end
end
