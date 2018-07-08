require_relative '../spec_helper.rb'
require_relative '../../app.rb'

RSpec.describe App  do

  before(:context) do
    UserCategory.create({ user_id: 1, category_id: 1})
    UserCategory.create({ user_id: 1, category_id: 3})
  end

  it 'should display select categories page with all categories' do
    get '/categories', {}, { 'rack.session' => { user_id: 1 } }

    expect(last_response).to be_redirect
    follow_redirect!

    puts last_response.body


     
    expect(last_response.body).to include("Customize your learning")
    expect(last_response.body).to include("general")
    expect(last_response.body).to include("technology")
    expect(last_response.body).to include("sports")
    expect(last_response.body).to include("business")
    expect(last_response.body).to include("science")
  end

end
