require 'erb'


def show_admin_login_page
    erb :"admin/login"
end


def login_admin(admin_details)
    logger.info admin_details
    @admin = User.find_by(username: admin_details[:username]).try(:authenticate, admin_details[:password])

    if @admin && @admin.is_admin
        session[:admin] = @admin
        session[:admin_id] = @admin.id
        logger.info session[:admin]
        redirect to('/admin/dashboard')
    else
        @error = "Invalid username or password"
        show_admin_login_page
    end
end

def show_dashboard
    erb :"admin/dashboard"
end