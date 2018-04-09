require 'httparty'

# @author TROTTIER Arthur
# @since 0.1.0
# @note free up to 60 requests per minute

API_KEY = '2ef02bfc5d85b81c1564777e08ebb821'

# Researching weather data

class Weather

	#
	# @param [String] City's name
	# @return [Hash] Weather's data
	def self.getWeather(city)

		forURL = URI.parse(URI.escape('http://api.openweathermap.org/data/2.5/forecast?APPID='+API_KEY+'&q='+city+'&units=metric&lang=fr'))
		curURL = URI.parse(URI.escape('http://api.openweathermap.org/data/2.5/weather?APPID='+API_KEY+'&q='+city+'&units=metric&lang=fr'))
		forData = HTTParty.get(forURL).parsed_response
		curData = HTTParty.get(curURL).parsed_response

		if !forData.has_value?('404')  || !curData.has_value?('404') then

			dataDateOne = forData['list'][8]['dt_txt'].split(" ").first.split("-").map(&:to_i)
			dataDateTwo = forData['list'][16]['dt_txt'].split(" ").first.split("-").map(&:to_i)
			dataDateThree = forData['list'][24]['dt_txt'].split(" ").first.split("-").map(&:to_i)

			d1 = getDayString(Date.new(dataDateOne[0],dataDateOne[1],dataDateOne[2]).cwday)
			d2 = getDayString(Date.new(dataDateTwo[0],dataDateTwo[1],dataDateTwo[2]).cwday)
			d3 = getDayString(Date.new(dataDateThree[0],dataDateThree[1],dataDateThree[2]).cwday)

			weather = {'temp' => curData['main']['temp'], 'text' => curData['weather'].first['description'], 'logo' => curData['weather'].first['icon']}
			one = {'date' => forData['list'][8]['dt_txt'],'day' => d1,'temp' => forData['list'][8]['main']['temp'], 'tempmin' => forData['list'][8]['main']['temp_min'], 'tempmax' => forData['list'][8]['main']['temp_max'], 'logo' => forData['list'][8]['weather'].first['icon']}
			two = {'date' => forData['list'][16]['dt_txt'],'day' => d2,'temp' => forData['list'][16]['main']['temp'], 'tempmin' => forData['list'][16]['main']['temp_min'], 'tempmax' => forData['list'][16]['main']['temp_max'], 'logo' => forData['list'][16]['weather'].first['icon']}
			three = {'date' => forData['list'][24]['dt_txt'],'day' => d3,'temp' => forData['list'][24]['main']['temp'], 'tempmin' => forData['list'][24]['main']['temp_min'], 'tempmax' => forData['list'][24]['main']['temp_max'], 'logo' => forData['list'][24]['weather'].first['icon']}
			return {'info' => {'city' => city},'actual'=> weather,'forecast'=>[one,two,three]}

		else
			return {'Error' => city + " not found"}
		end
	end

	#
	# @param [Integer] Week's number
	# @return [String] Week's day
	def self.getDayString(n)
		case n
		when 1
			return "Lundi"
		when 2
			return "Mardi"
		when 3
			return "Mercredi"
		when 4
			return "Jeudi"
		when 5
			return "Vendredi"
		when 6
			return "Samedi"
		when 7
			return "Dimanche"
		end
	end
end


#puts JSON.pretty_generate(Weather.getWeather('Marseille'))
