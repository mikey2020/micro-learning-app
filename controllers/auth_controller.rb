require_relative '../models/user.rb'
require_relative './admin_controller.rb'
require_relative './user_controller.rb'

def login_user(login_details)
  authorize_user(
    login_details,
    'user',
    'Invalid username or password'
  )
end

def login_admin(admin_details)
  authorize_user(
    admin_details,
    'admin',
    'You are not authorised to view this page'
  )
end

def authorize_user(params, type, error_message)
  @user = User.find_by(username: params[:username])
              .try(:authenticate, params[:password])
  if @user
    session["#{type}_id"] = @user.id
    if type == 'admin'
      redirect to('/admin/dashboard')
    else
      redirect to('/home')
    end
  else
    @error = error_message
    if type == 'admin'
      show_admin_login_page
    else
      show_login_page
    end
  end
end