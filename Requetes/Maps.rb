

##
# Gratuit jusqu'à 2 500 requêtes par jour.

require 'google_maps_service'

class Maps

  @@API_KEY = 'AIzaSyAzfvWguWlvxRMPI2mFPI-BaW_-ufQxl8o'

  def initialize

    # Setup API keys
    @gmaps = GoogleMapsService::Client.new(key: @@API_KEY)

  end

  def requete(uneVille)
    data = @gmaps.geocode(uneVille)
    return data.first
  end


end

teste = Maps.new

res = teste.requete('le Mans')

p res

p res['address_components']

res.each_key {|key| puts "#{key}" }
