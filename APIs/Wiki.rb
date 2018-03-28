# Base class for researched wiki's data.
#
# @author SEBILLE Florian
# @since 0.1.0

require 'httparty'

class Wiki

  #@@API_KEY = 'AIzaSyAzfvWguWlvxRMPI2mFPI-BaW_-ufQxl8o'

  #
  # @param [String] searched city's name
  # @return [Hash] the resulting of this research

  def self.giveData(source)
    data = source.fetch("query").fetch("pages").values.first.fetch("revisions").first.fetch("*")
    tabData = data[0..data.index("siteweb")].split("{{")
    tabData.each { |elem|
      #elem = elem.split("=")
      puts elem
    }
    #return {'city' => data.first.fetch(:address_components).first.fetch(:long_name)}
  end

  def self.getWikiInfo(city)
    data = HTTParty.get('https://fr.wikipedia.org/w/api.php?action=query&titles=' + city + '&prop=revisions&rvprop=content&format=json').parsed_response
    self.giveData(data)
  end


end

Wiki.getWikiInfo('le Mans')

#puts JSON.pretty_generate(teste)

#p teste
#ind1 = teste.index("{{")
#ind2 = teste.index("}}")

#p teste[ind1+2..ind2+1]
#m = teste.split("{{").select{ |str|
#  str.include?("maire")
#}
#puts JSON.pretty_generate(teste)
