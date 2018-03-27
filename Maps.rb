

##
# Gratuit jusqu'à 2 500 requêtes par jour.

require 'google_maps_service'

class Maps

  @@apiKey = 'AIzaSyAzfvWguWlvxRMPI2mFPI-BaW_-ufQxl8o'

  def initialize

    # Setup API keys
    @gmaps = GoogleMapsService::Client.new(key: @@apiKey)

  end

  def requete(uneVille)
    res = @gmaps.geocode(uneVille)

  end


end

teste = Maps.new

res = teste.requete('le Mans')

#res.first.each {|key, value| puts "#{key} is #{value}" }

res.first.each_key {|key| puts "#{key}" }

puts res.first['geometry']


#[{:address_components=>[{:long_name=>"Le Mans", :short_name=>"Le Mans", :types=>["locality", "political"]}, {:long_name=>"Sarthe", :short_name=>"Sarthe", :types=>["administrative_area_level_2", "political"]}, {:long_name=>"Pays de la Loire", :short_name=>"Pays de la Loire", :types=>["administrative_area_level_1", "political"]}, {:long_name=>"France", :short_name=>"FR", :types=>["country", "political"]}], :formatted_address=>"Le Mans, France", :geometry=>{:bounds=>{:northeast=>{:lat=>48.0358609, :lng=>0.255099}, :southwest=>{:lat=>47.927934, :lng=>0.136286}}, :location=>{:lat=>48.00611000000001, :lng=>0.199556}, :location_type=>"APPROXIMATE", :viewport=>{:northeast=>{:lat=>48.0358609, :lng=>0.255099}, :southwest=>{:lat=>47.927934, :lng=>0.136286}}}, :place_id=>"ChIJMarzFNKI4kcRf-B9akxdAmk", :types=>["locality", "political"]}]
