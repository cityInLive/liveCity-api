require 'httparty'

API_KEY = '2ef02bfc5d85b81c1564777e08ebb821'

class Weather

	def self.getWeather(city)

		forData = HTTParty.get('http://api.openweathermap.org/data/2.5/forecast?APPID='+API_KEY+'&q='+city+'&units=metric&lang=fr').parsed_response
		curData = HTTParty.get('http://api.openweathermap.org/data/2.5/weather?APPID='+API_KEY+'&q='+city+'&units=metric&lang=fr').parsed_response

		weather = {'temp' => curData['main']['temp'], 'text' => curData['weather'].first['description'], 'logo' => curData['weather'].first['icon']}
		one = {'temp' => forData['list'][8]['main']['temp'], 'tempmin' => forData['list'][8]['main']['temp_min'], 'tempmax' => forData['list'][8]['main']['temp_max'], 'logo' => forData['list'][8]['weather'].first['icon']}
		two = {'temp' => forData['list'][16]['main']['temp'], 'tempmin' => forData['list'][16]['main']['temp_min'], 'tempmax' => forData['list'][16]['main']['temp_max'], 'logo' => forData['list'][16]['weather'].first['icon']}
		three = {'temp' => forData['list'][24]['main']['temp'], 'tempmin' => forData['list'][24]['main']['temp_min'], 'tempmax' => forData['list'][24]['main']['temp_max'], 'logo' => forData['list'][24]['weather'].first['icon']}

		#puts forData['list'][8]

		return {'info' => [{'city' => city},weather,one,two,three]}
	end

end

#Weather.getWeather('Le Mans')
