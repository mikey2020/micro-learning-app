require 'dotenv/load'
require 'news-api'

require_relative '../models/page.rb'
require_relative '../helpers/user_categories.rb'

def new_page
  all_pages = pages
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
    rescue StandardError
      saved_page = Page.find(@user.last_page) unless @user.last_page.nil?
      @page = all_pages.sample while @page.url == saved_page.url
    end
  end
  @user.update(last_page: new_page.id) unless new_page.nil?
  erb :home
end

def show_home_page
  @user = User.find(session[:user_id])
  result = Time.diff(
    Time.parse(@user.updated_at.to_s),
    Time.parse(Time.now.to_s), '%H %N %S'
  )
  if result[:diff].to_i >= 24 || @user.last_page.nil?
    new_page
  else
    @page = Page.find(@user.last_page)
    erb :home
  end
end

def pages
  newsapi = News.new(ENV['API_KEY'])
  @categories = user_categories.map(&:name)
  pages = []
  @categories.uniq.each do |cat|
    begin
      top_headlines = newsapi.get_top_headlines(category: cat,
                                                language: 'en',
                                                country: 'us')
      pages.push(top_headlines[0])
    rescue StandardError
      @error = 'Something went wrong'
      erb :error_page
    end
  end
  pages
end
