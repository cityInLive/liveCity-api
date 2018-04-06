# encoding: utf-8

require 'sinatra'
require_relative 'APIs/Weather'
require_relative 'APIs/Instagram'
require_relative 'APIs/Wikipedia'
require_relative 'APis/Twitter'

class Server < Sinatra::Base

	before do
		content_type :json, 'charset' => 'utf-8'
		headers 'Access-Control-Allow-Origin' => '*'
	end

	get '/' do
		'API: This is our API! The client is at https://livecity.vlntn.pw !'
	end

	get '/weather/:city' do
		Weather.getWeather(params['city'].to_s).to_json
	end

	get '/wikipedia/:city' do
		Wikipedia.getWikiInfo(params['city'].to_s).to_json
	end

	get '/instagram/:city' do
		Instagrame.getMediaInsta(params['city'].to_s).to_json
	end

	#get '/twitter/:lat,:long' do
	#	Twitter.getTweets(params['lat'].to_s,params['long'].to_s).to_json
	#end

end
