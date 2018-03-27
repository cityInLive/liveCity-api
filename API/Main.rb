require 'sinatra/json'
require 'sinatra'

get '/' do
	'API: This is our API! The client is <a href="https://livecity.vlntn.pw">here</a>.'
end

get '/test' do
	'Hello world! :)'
end

get '/api/route.json' do
  json key_1: 'value 1', key_2: 'value_2'
end
