require 'sinatra'
require '../Requetes/Weather.rb'

get '/' do
	'API: This is our API! The client is <a href="https://livecity.vlntn.pw">here</a>.'
end

get '/test' do
	'Hello world! :)'
end

get '/weather/:city' do
	content_type :json
	Weather.getWeather(params['city'].to_s).to_json
end
