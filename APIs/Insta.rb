require 'httparty'
require 'instagram'
require 'instagram_api_client'

# @author SEBILLE Florian
# @since 0.1.0

# Researching weather data

class Insta

  @@ACCES_TOKEN = '7423327355.ff1858c.426f98ed0af64e2c88bf946681cbf645'

  Instagram.configure do |config|
    config.client_id = "ff1858ce0188426aa415989540c0db1a"
    config.access_token = '7423327355.ff1858c.426f98ed0af64e2c88bf946681cbf645'
  end

	#
	# @param [String] city's name
	# @return
	def self.getMediaInsta(city)
    #return Instagram.media_search("48.8588377","2.2770206")
    #return InstagramApi.location.search({lat: 48.8588377, lng: 2.2770206})
    #return InstagramApi.media.search(search_query)
    #return HTTParty.get('https://api.instagram.com/v1/media/search?lat=48.8588377&lng=2.2770206&access_token=7423327355.ff1858c.426f98ed0af64e2c88bf946681cbf645').parsed_response
    return HTTParty.get('https://api.instagram.com/v1/media/search?lat=48.858844&lng=2.294351&access_token=7423327355.ff1858c.426f98ed0af64e2c88bf946681cbf645').parsed_response
    #return HTTParty.get('https://api.instagram.com/v1/tags/nofilter/media/recent?access_token=7423327355.ff1858c.426f98ed0af64e2c88bf946681cbf645').parsed_response
    #return HTTParty.get('https://api.instagram.com/v1/media/search?lat={48.8588377}&lng={2.2770206}&access_token={7423327355.ff1858c.426f98ed0af64e2c88bf946681cbf645}').parsed_response

  end

end

rep = Insta.getMediaInsta('le Mans')

p rep

#https://www.instagram.com/oauth/authorize/?client_id=ff1858ce0188426aa415989540c0db1a&redirect_uri=https://livecity.vlntn.pw/&response_type=token&scope=public_content
