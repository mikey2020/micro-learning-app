require_relative '../models/category.rb'

def get_user_categories(user_id)
  Category.includes(:user_categories).where(user_categories: {user_id: user_id})
end
