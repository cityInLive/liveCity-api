

##
# Gratuit jusqu'à 2 500 requêtes par jour.

require 'google_maps_service'
require 'httparty'

class Maps

  @@API_KEY = 'AIzaSyAzfvWguWlvxRMPI2mFPI-BaW_-ufQxl8o'

  def initialize

    # Setup API keys
    @gmaps = GoogleMapsService::Client.new(key: @@API_KEY)

  end


  def requete(uneVille)
    
    return HTTParty.get('https://maps.googleapis.com/maps/api/js?key=' + @@API_KEY).parsed_response

  end


end

teste = Maps.new

res = teste.requete('le Mans')

p res
