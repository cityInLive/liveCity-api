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
        return elem
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

    res["region"] = self.chercheData(tabData, "région")
    res["Departement"] = self.chercheData(tabData, "département")
    res["maire"] = self.chercheData(tabData, "maire")
    res["cp"] = self.chercheData(tabData, "cp")
    res["population"] = self.chercheData(tabData, "population")
    res["populationAgglo"] = self.chercheData(tabData, "population agglomération")

    return res
  end

  def self.getWikiInfo(city)
    data = HTTParty.get('https://fr.wikipedia.org/w/api.php?action=query&titles=' + city + '&prop=revisions&rvprop=content&rvsection=0&format=json').parsed_response
    return self.giveData(data, city)
  end


end

#Wiki.getWikiInfo('Beijing')
