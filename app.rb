require 'sinatra/base'
require 'dotenv/load'
require 'sysrandom/securerandom'

current_dir = Dir.pwd

Dir["#{current_dir}/controllers/*.rb"].each { |file| require file }
Dir["#{current_dir}/helpers/*.rb"].each { |file| require file }

class App < Sinatra::Application

    # set :sessions, true
    enable :sessions, :logging

    # set :session_store, Rack::Session::Pool
    set :session_secret, SecureRandom.hex(64)
 
    configure :development do
        set :database, { adapter: 'postgresql',  encoding: 'unicode', database: ENV['DATABASE_NAME'], pool: 5, username: ENV['DATABASE_USER'], password: ENV['DATABASE_PASSWORD'] }
    end
      
    configure :production do
        set :database, { adapter: 'postgresql',  encoding: 'unicode', database: ENV['DATABASE_NAME'], pool: 5, username: ENV['DATABASE_USER'], password: ENV['DATABASE_PASSWORD'] }
    end

    configure :test do
        set :database, { adapter: 'sqlite3',  encoding: 'unicode', database: 'db/test.sqlite3' , pool: 5 }
    end

    before '/home' do
        authenticate('/home')
    end

    get '/home' do
        unless session[:user].nil?
            @username = session[:user].username
        end
        "Hello #{@username}"
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


    not_found do
        'This is nowhere to be found.'
    end


    run! if app_file == $0
    
end