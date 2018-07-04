require 'erb'
require 'pry'

current_dir = Dir.pwd
require "#{current_dir}/models/user.rb"

def create_user(user_details)
    logger.info params
    logger.info "Creating new model instance"
    @user = User.new(user_details)
    if @user.save
        session[:user] = @user
        session[:user_id] = @user.id
        logger.info session[:user]
        redirect to('/home')
    else 
        @errors = @user.errors.messages
        erb :"user/signup"
    end
end

def new_user
    erb :"user/signup"
end