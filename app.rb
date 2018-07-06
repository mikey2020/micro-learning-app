require 'sinatra/base'
require 'dotenv/load'
require 'sysrandom/securerandom'
require 'news-api'
require 'time_diff'

current_dir = Dir.pwd

Dir["#{current_dir}/models/*.rb"].each { |file| require file }
Dir["#{current_dir}/controllers/*.rb"].each { |file| require file }
Dir["#{current_dir}/helpers/*.rb"].each { |file| require file }

class App < Sinatra::Application

    newsapi = News.new(ENV['API_KEY'])

    set :show_exceptions, :after_handler

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
        authenticate
    end

    before '/user/login' do
        if session[:user_id]
            redirect to('/home')
        end
    end

    before '/categories' do
        if session[:user_id].nil?
            redirect to('/user/login')
        end
    end

    get '/home' do
        @user = User.find(session[:user_id])

        result = Time.diff(Time.parse(@user.updated_at.to_s), Time.parse(Time.now.to_s), '%H %N %S')
      if result[:hour] >= 24 || @user.created_at == @user.updated_at

        unless session[:user].nil?
            @username = session[:user].username
        end
        @categories = get_user_categories.map { |cat| cat.name}

        all_pages = []
        @categories.uniq.each do |cat|
            begin
                top_headlines = newsapi.get_top_headlines(category: cat,
                                                        language: 'en',
                                                        country: 'us')

                puts top_headlines
                all_pages.push(top_headlines[0])
            rescue Exception => e
                @error = e.message
                erb :error_page
            end
        end

        unless all_pages.nil?
          @page_url = all_pages.sample.url
          while @page_url == @user.last_page
            @page_url = all_pages.sample.url
          end
        end
      
        @user.update(last_page: @page_url)

        erb :home

      else 
        @page_url = @user.last_page

        erb :home
      end
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

    get '/user/select' do
      erb :"user/select_page"
    end

    get '/categories' do
        begin
          sources = newsapi.get_sources(country: 'us', language: 'en')

          @categories = []
          sources.each do |source|
            @categories.push(source.category)
          end

          session[:categories] = @categories

          erb :"user/select_page"
        rescue Exception => e
            @error = e.message
            erb :error_page
        end
    end

    post '/categories' do
        logger.info params
        params[:categories].each do |cat|
            @category = Category.where(name: cat).take
            UserCategory.create(user_id: session[:user_id], category_id: @category.id)
        end
        redirect to('/home')
    end


    def get_user_categories
        Category.includes(:user_categories).where(user_categories: {user_id: session[:user_id]})
    end


    not_found do
        'This is nowhere to be found.'
    end


    run! if app_file == $0
    
end