require 'httparty'
require 'twitter'

# @author TROTTIER Arthur
# @since 0.1.


# Researching tweets

class TwitterAPI

	#
	# @param [float] latitude
	# @param [float] longitude
	# @return [Hash] tweets's data
	def self.getTweets(lat,long)

		code = lat.to_s
		code << ","
		code << long.to_s
		code << ",5km"
		hash = {}
		hash["lat"] = lat
		hash["long"] = long
		hash["tweets"] = []
		tw = {}

		client = Twitter::REST::Client.new do |config|
			config.consumer_key        = 'KMXsBWU4Oi9Zymcfd7ociGAqB'
			config.consumer_secret     = 'lnK4MgKPsMgE8zrJBk2HZkX5K9mUs6hjaQfBjNb5n5pMr63TRU'
			config.access_token        = '978921024526970880-vtfbWaaMHnEU1V5YIUYf4DTLG262Wl3'
			config.access_token_secret = '4LedHyiaBevvUao0aeOu4ONSv1G4CMV4RD5dYzX8z94aw'
		end

		client.search(" ",geocode:code.to_s).take(100).each_with_index do |tweet,index|
			if !"#{tweet.full_text}".include? "RT" then

				days = "#{tweet.created_at}".split(" ")[0]
				heure = "#{tweet.created_at}".split(" ")[1]
				date = days.split("-")[2]
				date << " "
				date << getMonth(days.split("-")[1])

				tw['tweetname'] = "#{tweet.user.name}"
				tw['name'] = "#{tweet.user.screen_name}"
				tw['tweetname'] = "#{tweet.user.name}"
				tw['picture'] = "#{tweet.user.profile_image_uri_https}"
				tw['text'] = "#{tweet.full_text}"
				tw['like'] = "#{tweet.favorite_count}"
				tw['retweet'] = "#{tweet.retweet_count}"
				tw['date'] = date
				tw['time'] = heure
				tw['url_tweet'] = "#{tweet.uri}"
				tw['url_user'] = "#{tweet.user.uri}"
				hash["tweets"] << tw
				tw = {}

			end
		end
		return hash
	end

	def self.getMonth(num)
		case num
		when "01"
			return "Janvier"
		when "02"
			return "Fevrier"
		when "03"
			return "Mars"
		when "04"
			return "Avril"
		when "05"
			return "Mai"
		when "06"
			return "Juin"
		when "07"
			return "Juillet"
		when "08"
			return "Aout"
		when "09"
			return "Septembre"
		when "10"
			return "Octobre"
		when "11"
			return "Novembre"
		when "12"
			return "Decembre"
		end
	end
end


# TEST

# client = Twitter::REST::Client.new do |config|
# 	config.consumer_key        = 'KMXsBWU4Oi9Zymcfd7ociGAqB'
# 	config.consumer_secret     = 'lnK4MgKPsMgE8zrJBk2HZkX5K9mUs6hjaQfBjNb5n5pMr63TRU'
# 	config.access_token        = '978921024526970880-vtfbWaaMHnEU1V5YIUYf4DTLG262Wl3'
# 	config.access_token_secret = '4LedHyiaBevvUao0aeOu4ONSv1G4CMV4RD5dYzX8z94aw'
# end
#
# client.search('to:justinbieber').take(100).collect do |tweet|
# 	puts "#{tweet.user.screen_name} : #{tweet.full_text}"
# end

#puts JSON.pretty_generate(TwitterAPI.getTweets(48.866667,2.333333))
