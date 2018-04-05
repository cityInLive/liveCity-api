require 'sinatra'
require_relative 'APIs/Weather'
require_relative 'APIs/Insta'
require_relative 'APIs/Wiki'

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

get '/wiki/:city' do
	content_type :json
	headers 'Access-Control-Allow-Origin' => 'http://localhost:9000'
	Wiki.getWikiInfo(params['city'].to_s).to_json
end

get '/insta/:city' do
	content_type :json
	headers 'Access-Control-Allow-Origin' => 'http://localhost:9000'
	Insta.getMediaInsta(params['city'].to_s).to_json
end
