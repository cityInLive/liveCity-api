require 'httparty'
require 'twitter'

# @author TROTTIER Arthur
# @since 0.1.


# Researching tweets

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = 'KMXsBWU4Oi9Zymcfd7ociGAqB'
  config.consumer_secret     = 'lnK4MgKPsMgE8zrJBk2HZkX5K9mUs6hjaQfBjNb5n5pMr63TRU'
  config.access_token        = '978921024526970880-vtfbWaaMHnEU1V5YIUYf4DTLG262Wl3'
  config.access_token_secret = '4LedHyiaBevvUao0aeOu4ONSv1G4CMV4RD5dYzX8z94aw'
end

client.search(" ",geocode: "44.467186,-73.214804,5km").take(3).collect do |tweet|
	if !"#{tweet.full_text}".include? "RT" then
		puts "(#{tweet.user.screen_name}/#{tweet.user.profile_image_uri_https}) : #{tweet.full_text}","\n"
	end
end
