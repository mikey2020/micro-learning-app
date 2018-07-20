require_relative '../models/user.rb'
require_relative './admin_controller.rb'
require_relative './user_controller.rb'

def login_user(login_details)
  authorize_user(
    login_details,
    'Invalid username or password'
  )
end

def login_admin(admin_details)
  authorize_user(
    admin_details,
    'You are not authorised to view this page'
  )
end

def authorize_user(params, error_message)
  @user = User.find_by(username: params[:username]).
    try(:authenticate, params[:password])
  if @user
    session[:user_id] = @user.id
    if @user.is_admin?
      session[:admin] = @user.is_admin
      redirect to('/admin/dashboard')
    else
      redirect to('/home')
    end
  else
    @error = error_message
    erb :"user/login"
  end
end

def user_logged_in?
  if session[:user_id]
    true
  else
    false
  end
end

def admin?
  if session[:admin]
    true
  else
    false
  end
end
