require 'httparty'

API_KEY = '2ef02bfc5d85b81c1564777e08ebb821'

class Weather

	@city
	@temp
	@temp_min
	@temp_max
	@description
	@logoid

	def initialize(city)
		@city = city
		data = HTTParty.get('http://api.openweathermap.org/data/2.5/forecast?APPID='+API_KEY+'&q=Le Mans&units=metric&lang=fr').parsed_response
	end

	def getWeather

	end

end

hash = HTTParty.get('http://api.openweathermap.org/data/2.5/forecast?APPID='+API_KEY+'&q=Le Mans&units=metric&lang=fr').parsed_response
puts JSON.pretty_generate(hash["list"][8])
