require_relative '../models/user.rb'

def create_user(user_details)
  @user = User.new(user_details)
  if @user.save
    session[:user] = @user
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

def login_user(login_details)
  @current_user = User.find_by(username: login_details[:username]).try(:authenticate, login_details[:password])

  if @current_user
    session[:user] = @current_user
    session[:user_id] = @current_user.id
    logger.info session[:user]
    redirect to('/home')
  else
    @error = "Invalid username or password"
    show_login_page
  end
end