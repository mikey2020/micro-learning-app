current_dir = Dir.pwd
require "#{current_dir}/models/category.rb"
require "#{current_dir}/helpers/get_categories.rb"
require 'dotenv/load'
require 'news-api'
require 'pry'

def get_new_page

    newsapi = News.new(ENV['API_KEY'])

    if session[:user]
        @username = session[:user].username
    end

    @categories = get_user_categories.map { |cat| cat.name }
    
    all_pages = []
    @categories.uniq.each do |cat|
        begin
            top_headlines = newsapi.get_top_headlines(category: cat,
                                                    language: 'en',
                                                    country: 'us')
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

end

def show_home_page
    @user = User.find(session[:user_id])

    result = Time.diff(Time.parse(@user.updated_at.to_s), Time.parse(Time.now.to_s), '%H %N %S')
    if result[:hour] >= 24 || @user.last_page.nil?
      get_new_page
    else 
      @page_url = @user.last_page

      erb :home
    end
end