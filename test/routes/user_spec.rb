require_relative '../spec_helper.rb'
require_relative '../../app.rb'

RSpec.describe App  do

  it 'should display user sign up page' do
    get '/user/signup'
    expect(last_response).to be_ok
    expect(last_response.body).to include("username")
    expect(last_response.body).to include("email")
    expect(last_response.body).to include("password")
  end

  it 'should display error message when username is empty' do
    post '/user/signup', params={ user: { username: "  ", email: "naruto@email.com", password: "tester123" } }
    
    puts last_response
    expect(last_response).to be_ok
    expect(last_response.body).to include("username can't be blank")
  end

  it 'should display error message when password is not alphanumeric' do
    post '/user/signup', params={ user: { username: "test", email: "test@email.com", password: "tester" } }

    expect(last_response).to be_ok
    expect(last_response.body).to include("password must be an alphanumeric")
  end

  it 'should display error message when password is empty' do
    post '/user/signup', params={ user: { username: "test", email: "test@email.com", password: "" } }
    
    expect(last_response).to be_ok
    expect(last_response.body).to include("password can't be blank")
  end

  it 'should display error message when email is empty' do
    post '/user/signup', params={ user: { username: "test", email: "", password: "tester123" } }
    
    expect(last_response).to be_ok
    expect(last_response.body).to include("email must be valid")
  end
end
