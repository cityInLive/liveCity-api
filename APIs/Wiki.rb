# Base class for researched wiki's data.
#
# @author SEBILLE Florian
# @since 0.1.0

require 'httparty'

class Wiki


  def self.chercheData(tabData, valeur)

    tabData.each { |elem|
      if elem.include?(valeur) then
        elem = elem.split("=")[1].delete "["
        elem = elem.delete "]"
        if valeur.eql?("cp") then
          unless elem.split("|")[1].eql?(nil) then
            elem = elem.split("|")[1]
          end
        end
        return elem.delete "\n"
      end
    }
    return nil
  end

  def self.chercheSummary(tabData)
    tab = tabData.split(". ")
    tab.each { |elem|
      if elem.include?("'''") then
        return elem[elem.index("'''")..-1]
      end
    }
  end


  #@@API_KEY = 'AIzaSyAzfvWguWlvxRMPI2mFPI-BaW_-ufQxl8o'

  #
  # @param [String] searched city's name
  # @return [Hash] the resulting of this research

  def self.giveData(source, city)
    res = Hash.new

    data = source.fetch("query").fetch("pages").values.first.fetch("revisions").first.fetch("*")

    res["summary"] = self.chercheSummary(data)

    tabData = data[1..data.index("'''")].split("| ")

    ["région", "département", "maire", "cp", "population", "population agglomération", "superficie"].each { |valeur|

      donnee = self.chercheData(tabData, valeur)

      unless donnee.eql?(nil) then
        if donnee.length > 2 then
          res[valeur] = donnee
        end
      end
    }

    return res
  end

  def self.getWikiInfo(city)
    data = HTTParty.get('https://fr.wikipedia.org/w/api.php?action=query&titles=' + city + '&prop=revisions&rvprop=content&rvsection=0&format=json').parsed_response
    return self.giveData(data, city)
  end


end

rep = Wiki.getWikiInfo('Londres')

rep.each { |key, valeur|
  puts key + ":"
  p valeur
}
