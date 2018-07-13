require 'erb'

def show_admin_login_page
  erb :"admin/login"
end

def show_dashboard
  erb :"admin/dashboard"
end