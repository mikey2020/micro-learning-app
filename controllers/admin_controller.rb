require_relative '../models/user.rb'

def delete_user
  @user = User.find(params[:user_id]).destroy
end

def show_admin_login_page
  erb :"admin/login"
end

def show_dashboard
  users = User.all
  @user = User.find(session[:user_id])
  @users = []
  users.each do |user|
    @users.append(user) unless user.username == @user.username
  end
  erb :"admin/dashboard"
end
