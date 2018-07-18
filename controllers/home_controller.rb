require 'dotenv/load'
require 'news-api'

require_relative '../models/page.rb'
require_relative '../helpers/get_categories.rb'

def get_new_page
  newsapi = News.new(ENV['API_KEY'])

  @categories = get_user_categories.map { |cat| cat.name }
  
  all_pages = []
  @categories.uniq.each do |cat|
    begin
      top_headlines = newsapi.get_top_headlines(category: cat,
                                              language: 'en',
                                              country: 'us')
      all_pages.push(top_headlines[0])
    rescue
      @error = "Something went wrong"
      erb :error_page
    end
  end

  unless all_pages.nil?
    @page = all_pages.sample
    begin
      new_page = Page.create(
                  name: @page.name, 
                  description: @page.description, 
                  url: @page.url,
                  urlToImage: @page.urlToImage,
                  user_id: @user.id
                )
      new_page.save
    rescue
      saved_page = Page.find(@user.last_page) unless @user.last_page.nil?
      while @page.url == saved_page.url
        @page = all_pages.sample
      end
    end
  end
  
  
  @user.update(last_page: new_page.id) unless new_page.nil?

  erb :home
end

def show_home_page
  @user = User.find(session[:user_id])
  result = Time.diff(Time.parse(@user.updated_at.to_s), Time.parse(Time.now.to_s), '%H %N %S')
  if result[:hour] >= 24 || @user.last_page.nil?
    get_new_page
  else 
    @page = Page.find(@user.last_page)
    erb :home
  end
end