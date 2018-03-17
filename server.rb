require 'sinatra'

get '/' do
	'API: This is our API! The client is <a href="https://livecity.vlntn.pw">here</a>.'
end

get '/test' do
	'Hello world! :)'
end
