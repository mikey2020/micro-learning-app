require_relative '../models/category.rb'

def get_categories
  @categories = Category.all.map { |cat| cat.name }
  erb :"user/select_page"
end

def add_user_categories
  params[:categories].each do |cat|
    @category = Category.where(name: cat).take
    UserCategory.create(
      user_id: session[:user_id],
      category_id: @category.id
    )
  end
    
  redirect to('/home')
end 