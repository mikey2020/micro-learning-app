require 'erb'
require_relative '../models/user.rb'

def create_user(user_details)
  @user = User.new(user_details)
  if @user.save
    session[:user_id] = @user.id
    redirect to('/categories')
  else 
    @errors = @user.errors.messages
    erb :"user/signup"
  end
end

def new_user
  erb :"user/signup"
end

def show_login_page
  erb :"user/login"
end