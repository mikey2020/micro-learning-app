require 'erb'
require_relative '../models/user.rb'

def delete_user
  @user = User.find(params[:user_id]).destroy
end

def show_admin_login_page
  erb :"admin/login"
end

def show_dashboard
  @users = User.all
  erb :"admin/dashboard"
end