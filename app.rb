require 'sinatra/base'
require 'sinatra/activerecord'
require 'erb'


class App < Sinatra::Base

    get '/' do
        erb :index
    end


    run! if app_file == $0
    
end