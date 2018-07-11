require 'erb'
current_dir = Dir.pwd

require "#{current_dir}/models/user.rb"

def show_admin_login_page
    erb :"admin/login"
end


def login_admin(admin_details)
    logger.info admin_details
    @admin = User.find_by(username: admin_details[:username]).try(:authenticate, admin_details[:password])

    if @admin && @admin.is_admin
        session[:admin] = @admin
        session[:admin_id] = @admin.id
        redirect to('/admin/dashboard')
    else
        @error = "Invalid username or password"
        show_admin_login_page
    end
end

def show_dashboard
    @users = User.all
    erb :"admin/dashboard"
end

def delete_user
    @user = User.find(params[:user_id]).destroy
end