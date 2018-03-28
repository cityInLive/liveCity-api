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

  def self.getWikiInfo(city)
    data = HTTParty.get('https://fr.wikipedia.org/w/api.php?action=query&titles=' + city + '&prop=revisions&rvprop=content&format=json').parsed_response
    #return {'info' => [{'city' => city},data.first.fetch(:geometry).fetch(:location)]}
  end


end

teste = Wiki.getWikiInfo('le Mans')

#puts JSON.pretty_generate(teste)

teste = teste.fetch("query").fetch("pages")
teste.each_key { |key|
  p key
  #puts JSON.pretty_generate(content)
}
