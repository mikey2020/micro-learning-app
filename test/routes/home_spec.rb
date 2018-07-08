require_relative '../spec_helper.rb'
require_relative '../../app.rb'

RSpec.describe App  do

  it 'should display user"s page for the day' do
    get '/home', {}, { 'rack.session' => { user_id: 1 } }

    expect(last_response.body).to include("Your page for the day")
  end

end
