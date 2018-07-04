require_relative '../spec_helper.rb'
require_relative '../../app.rb'

RSpec.describe App  do

  it 'should display select categories page with all categories' do
    get '/categories'
    
    expect(last_response).to be_ok
    puts last_response
    expect(last_response.body).to include("general")
    expect(last_response.body).to include("technology")
    expect(last_response.body).to include("sports")
    expect(last_response.body).to include("business")
    expect(last_response.body).to include("science")
  end
end
