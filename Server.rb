# encoding: utf-8

require 'sinatra'
require_relative 'APIs/Weather'
require_relative 'APIs/Instagram'
require_relative 'APIs/Wikipedia'
require_relative 'APIs/Twitter'

class Server < Sinatra::Base

	set :show_exceptions, false

	error Exception do
		content_type :json, 'charset' => 'utf-8'
		headers 'Access-Control-Allow-Origin' => '*'
		status 500
		'{"Error": "' + env['sinatra.error'].message + '"}'
	end

	not_found do
		content_type :json, 'charset' => 'utf-8'
		headers 'Access-Control-Allow-Origin' => '*'
		status 404
		'{"Error": "404 - Page not found"}'
	end

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

	get '/wikipedia/:city,:departement' do
		Wikipedia.getWikiInfo(params['city'].to_s,params['departement'].to_s).to_json
	end

	get '/instagram/:city' do
		Instagrame.getMediaInsta(params['city'].to_s).to_json
	end

	get '/twitter/:lat,:long' do
		TwitterAPI.getTweets(params['lat'].to_s,params['long'].to_s).to_json
	end

end
