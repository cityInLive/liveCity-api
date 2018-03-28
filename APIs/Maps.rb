require 'google_maps_service'
require 'httparty'

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
    gmaps = GoogleMapsService::Client.new(key: @@API_KEY)

    data = gmaps.geocode(city)

    if data.empty? || !(data.first.fetch(:address_components).first.fetch(:long_name).include?(city)) then
      return {'Error' => "#{city} not found"}
    else return {'city' => data.first.fetch(:address_components).first.fetch(:long_name),'coords' => data.first.fetch(:geometry).fetch(:location)} end
  end


end

#teste = Maps.getCoordinates('ytvfwxb')
#puts teste
#{"Error"=>"ytvfwxb not found"}

#teste = Maps.getCoordinates('le mans')
#puts teste
#{"city"=>"Le Mans", "coords"=>{:lat=>48.00611000000001, :lng=>0.199556}}
