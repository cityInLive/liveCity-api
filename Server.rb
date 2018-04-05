# encoding: utf-8

require 'sinatra'
require_relative 'APIs/Weather'
require_relative 'APIs/Insta'
require_relative 'APIs/Wiki'

class Server < Sinatra::Base

	before do
		content_type :json, 'charset' => 'utf-8'
	end

	get '/' do
		'API: This is our API! The client is https://livecity.vlntn.pw.'
	end

	get '/weather/:city' do
		Weather.getWeather(params['city'].to_s).to_json
	end

	get '/wiki/:city' do
		headers 'Access-Control-Allow-Origin' => 'http://localhost:9000'
		Wiki.getWikiInfo(params['city'].to_s).to_json
	end

	get '/insta/:city' do
		headers 'Access-Control-Allow-Origin' => 'http://localhost:9000'
		Insta.getMediaInsta(params['city'].to_s).to_json
	end

end
