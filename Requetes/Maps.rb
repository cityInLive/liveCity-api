

require 'google_maps_service'

# Base class for researched maps's data.
#
# @author SEBILLE Florian
# @since 0.1.0
# @note free up to 2,500 requests per day.s

class Maps

  @@API_KEY = 'AIzaSyAzfvWguWlvxRMPI2mFPI-BaW_-ufQxl8o'

  #
  # @param [String] searched city's name
  # @return [Hash] the resulting of this research
  def self.getCoordinates(city)
    #gmaps = GoogleMapsService::Client.new(key: @@API_KEY)
    data = HTTParty.get('https://maps.googleapis.com/maps/api/place/textsearch/json?query=' + city + '&key=' + @@API_KEY).parsed_response
    p data
    #data = gmaps.geocode(city)

    #return {'info' => [{'city' => data.first.fetch(:address_components).first.fetch(:long_name)},data.first.fetch(:geometry).fetch(:location)]}
  end


end

teste = Maps.getCoordinates('le mans')

puts teste

#{"info"=>[{"city"=>"le Mans"}, {:lat=>48.00611000000001, :lng=>0.199556}]}
