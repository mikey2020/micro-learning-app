require_relative '../spec_helper.rb'
require_relative '../../app.rb'

RSpec.describe App do
  it 'displays index page' do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include('Welcome to Super micro learning app')
  end
end
