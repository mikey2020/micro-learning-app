require_relative '../models/category.rb'

def get_user_categories
  Category.includes(:user_categories).where(user_categories: {user_id: session[:user_id]})
end
