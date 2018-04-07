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

		client = Twitter::REST::Client.new do |config|
			config.consumer_key        = 'KMXsBWU4Oi9Zymcfd7ociGAqB'
			config.consumer_secret     = 'lnK4MgKPsMgE8zrJBk2HZkX5K9mUs6hjaQfBjNb5n5pMr63TRU'
			config.access_token        = '978921024526970880-vtfbWaaMHnEU1V5YIUYf4DTLG262Wl3'
			config.access_token_secret = '4LedHyiaBevvUao0aeOu4ONSv1G4CMV4RD5dYzX8z94aw'
		end

		client.search(" ",geocode:code.to_s).take(100).each_with_index do |tweet,index|
			if !"#{tweet.full_text}".include? "RT" then

				n = "tweet "
				n << index.to_s

				hash[n] = {}
					hash[n]['name'] = "#{tweet.user.screen_name}"
					hash[n]['tweetname'] = "#{tweet.user.	name}"
					hash[n]['picture'] = "#{tweet.user.profile_image_uri_https}"
					hash[n]['text'] = "#{tweet.full_text}"
					hash[n]['like'] = "#{tweet.favorite_count}"
					hash[n]['retweet'] = "#{tweet.retweet_count}"
					hash[n]['date'] = "#{tweet.created_at}"
					n = ""
			end
		end
		return hash
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

#puts JSON.pretty_generate(Twi.getTweets(48.866667,2.333333))
