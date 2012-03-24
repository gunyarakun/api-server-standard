require 'rspec'
require 'rack/test'
require 'json'

require './lib/api-server/application'

describe 'Apiserver Application' do
  include Rack::Test::Methods

  def app
    ApiServer::Application
  end

  it 'returns empty array when limit is given by 0' do
    get '/v1/users', {
      :limit => 0,
    }
    last_response.should be_ok
    JSON.parse(last_response.body)['body'].should == []
  end

  it 'returns all users without limit' do
    get '/v1/users'
    last_response.should be_ok
    body = JSON.parse(last_response.body)['body']
    body.length.should == 100
    body.each do |user|
      user[1].should == "User Name #{user[0]}"
    end
  end

  it 'add users and delete the user' do
    post '/v1/users', {
      :name => 'New User'
    }
    last_response.should be_ok
    body = JSON.parse(last_response.body)['body']
    id = body['id']

    get "/v1/users/#{id}"
    last_response.should be_ok
    body = JSON.parse(last_response.body)['body']
    body['id'].should == id

    delete "/v1/users/#{id}"
    last_response.should be_ok

    get "/v1/users/#{id}"
    last_response.should_not be_ok
  end
end
