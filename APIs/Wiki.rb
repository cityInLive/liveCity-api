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
        elem = elem[elem.index("'''")..-1]

        while(elem.include?("("))
          elem[elem[elem.index("(")..elem.index(")")]] = ""
        end

        while(elem.include?("[["))
          elem[elem.index("[[")..(elem.index("]]")+1)] = elem[(elem.index("[[")+2)..(elem.index("]]")-1)].split("|").first
        end
        return elem
      end
    }
  end

  def self.cherchePicture(city)
    data = HTTParty.get('https://fr.wikipedia.org/w/api.php?action=query&titles=' + city + '&prop=pageimages&format=json').parsed_response

    url = data.fetch('query').fetch("pages").values.first.fetch('thumbnail').fetch('source')

    url[url[url.index(url.split("/").select {|v| v.include?("px")}.first)..url.index("px")-1]] = "300"

    return url

  end

  #@@API_KEY = 'AIzaSyAzfvWguWlvxRMPI2mFPI-BaW_-ufQxl8o'

  #
  # @param [String] searched city's name
  # @return [Hash] the resulting of this research

  def self.giveData(source, city)
    res = Hash.new

    data = source.fetch("query").fetch("pages").values.first

    if data.key?("revisions") then
      data = data.fetch("revisions").first.fetch("*")

      self.cherchePicture(city)

      res["summary"] = self.chercheSummary(data)

      res["image"] = self.cherchePicture(city)

      tabData = data[1..data.index("'''")].split("| ")

      ["légende", "région", "département", "maire", "cp", "population", "population agglomération", "superficie"].each { |valeur|

        donnee = self.chercheData(tabData, valeur)

        unless donnee.eql?(nil) then
          if donnee.length > 2 then
            res[valeur] = donnee
          end
        end
      }
    else
      res["ERROR"] = {'code' => '007', 'message' => "#{city} not found"}
    end
    return res
  end

  def self.getWikiInfo(city)
    data = HTTParty.get('https://fr.wikipedia.org/w/api.php?action=query&titles=' + city + '&prop=revisions&rvprop=content&rvsection=0&format=json').parsed_response
    return self.giveData(data, city)
  end


end

#https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Paris_-_Eiffelturm_und_Marsfeld2.jpg/1164px-Paris_-_Eiffelturm_und_Marsfeld2.jpg

#rep = Wiki.getWikiInfo('Paris')

#rep.each { |key, valeur|
#  puts key + ":"
#  p valeur
#}
