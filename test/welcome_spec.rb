require_relative './spec_helper.rb'
require_relative '../app.rb'

RSpec.describe App  do

  it 'should display index page' do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include("Testing Deployment")
    expect(last_response.body).to include("Welcome Super ML")
  end
end
