require 'dotenv/load'
require 'erb'
require 'news-api'

require_relative './get_categories.rb'
require_relative '../models/page.rb'

def get_new_page(user)
  newsapi = News.new(ENV['API_KEY'])

  @categories = get_user_categories(user.id).map { |cat| cat.name }
  
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
    # binding.pry
    # begin
    new_page = Page.new(
                name: @page.name, 
                description: @page.description, 
                url: @page.url,
                urlToImage: @page.urlToImage,
                user_id: user.id
              )
    new_page.save
    # rescue Exception => e
    #   # puts e.class
    #   saved_page = Page.find(user.last_page) unless user.last_page.nil?
    #   while @page.url == saved_page.url
    #     @page = all_pages.sample
    #   end
    # end
  end
  
  
  user.update(last_page: new_page.id) unless new_page.nil?

  return @page
end
  