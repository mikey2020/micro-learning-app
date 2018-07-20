require 'sinatra/base'
require 'dotenv/load'
require 'sysrandom/securerandom'
require 'news-api'
require 'time_diff'

current_dir = Dir.pwd

Dir["#{current_dir}/models/*.rb"].each { |file| require file }
Dir["#{current_dir}/controllers/*.rb"].each { |file| require file }
Dir["#{current_dir}/helpers/*.rb"].each { |file| require file }

require_relative './workers/email_scheduler.rb'

# Sinatra application
class App < Sinatra::Application

  set :show_exceptions, :after_handler

  # set :sessions, true
  enable :sessions, :logging

  # set :session_store, Rack::Session::Pool
  set :session_secret, SecureRandom.hex(64)

  configure :development do
    set :database, {
      adapter: 'postgresql',
      encoding: 'unicode',
      database: ENV['DATABASE_NAME'],
      pool: 5,
      username: ENV['DATABASE_USER'],
      password: ENV['DATABASE_PASSWORD']
    }
  end
    
  configure :production do
    db = URI.parse(ENV['DATABASE_URL'])
  end

  configure :test do
    set :database, { adapter: 'sqlite3',  encoding: 'unicode', database: 'db/test.sqlite3' , pool: 5 }
  end

  before '/home' do
    authenticate
    if session[:user_id]
      categories = get_user_categories(session[:user_id])
      redirect to('/categories') if categories == []
    end
  end

  before '/user/login' do
    redirect to('/home') if session[:user_id]
  end

  before '/categories' do
    authenticate

    if session[:user_id]
      categories = get_user_categories(session[:user_id])

      redirect to('/home') unless categories == []
    end
  end

  before '/user/login' do
    redirect to('/admin/dashboard') if session[:admin_id]
  end

  before '/admin/dashboard' do
    redirect to('/admin/login') if session[:admin_id].nil?
  end

  get '/home' do
    show_home_page
  end

  get '/' do
    show_index
  end

  get '/user/signup' do
    new_user
  end

  post '/user/signup' do
    create_user(params[:user])
  end

  get '/user/login' do
    show_login_page
  end

  post '/user/login' do
    login_user(params[:user])
  end

  get '/user/logout' do
    session.clear
    redirect to('/user/login')
  end

  get '/user/select' do
    erb :"user/select_page"
  end

  get '/categories' do
    get_categories
  end

  post '/categories' do
    add_user_categories
  end

  get '/admin/login' do
    show_admin_login_page
  end

  post '/admin/login' do
    login_admin(params[:admin])
  end

  get '/admin/dashboard' do
    show_dashboard
  end

  get '/delete/:user_id' do
    delete_user
  end

  not_found do
    erb :not_found
  end

  run! if app_file == $0
end
