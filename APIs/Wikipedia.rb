# Base class for researched wiki's data.
#
# @author SEBILLE Florian
# @since 0.1.0

require 'httparty'

class Wikipedia


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

        if valeur.eql?("légende") then
          while(elem.include?("</"))

            fin = elem[elem.index("</")..-1]
            fin = fin[0..fin.index(">")]

            elem[elem[elem.index("<")..(elem.index(fin)) + fin.length]] = ""

          end

          while(elem.index("<br>"))
            elem[elem.index("<br>")..elem.index("<br>")+3] = ""
          end
           #elem = elem.delete "<br>"
        end

        return elem.delete "\n"
      end
    }
    return nil
  end

  def self.chercheSummary(tabData)
    tab = tabData.split(".\n\n")
    tab.each { |elem|
      if elem.include?("'''") then

        elem = elem[elem.index("'''")..-1]

        while(elem.include?("(") && elem.include?(")"))
          elem[elem[elem.index("(")..elem.index(")")]] = ""
        end

        while(elem.include?("</"))

          fin = elem[elem.index("</")..-1]
          fin = fin[0..fin.index(">")]

          elem[elem[elem.index("<")..(elem.index(fin)) + fin.length]] = ""

        end

        while(elem.include?("[["))
          tab = elem[(elem.index("[[")+2)..(elem.index("]]")-1)].split("|")
          unless tab.at(1).eql?(nil) then
            elem[elem.index("[[")..(elem.index("]]")+1)] = tab.at(1)
          else elem[elem.index("[[")..(elem.index("]]")+1)] = tab.first end
        end

        while(elem.include?("{{"))

          if elem.index("}}") < elem.index("{{") then
            elem["}}"] = ""
          end

          tab = elem[(elem.index("{{")+2)..(elem.index("}}")-1)].split("|")

          if tab.length.eql?(3) then
            elem[elem.index("{{")..(elem.index("}}")+1)] = tab.at(1) + " "+ tab.at(2)
          else elem[elem.index("{{")..(elem.index("}}")+1)] = tab.first end
        end
        elem = elem.delete "}}"
        return elem.delete "'"
      end
    }
  end

  def self.cherchePicture(city)

    url = URI.parse(URI.escape('https://fr.wikipedia.org/w/api.php?action=query&titles=' + city + '&prop=pageimages&format=json'))

    data = HTTParty.get(url).parsed_response

    if data.fetch('query').fetch("pages").values.first.has_key?('thumbnail') then
      url = data.fetch('query').fetch("pages").values.first.fetch('thumbnail').fetch('source')

      url[url[url.index(url.split("/").select {|v| v.include?("px")}.first)..url.index("px")-1]] = "600"

      return url
    end
    return false

  end

  def self.cherchePopulation(pageid)

    url = URI.parse(URI.escape('https://fr.wikipedia.org/w/api.php?format=json&action=parse&pageid=' + pageid + '&prop=text'))
    data = HTTParty.get(url).parsed_response

    if data.fetch('parse').fetch("text").has_key?('*') then
      donnee = data.fetch('parse').fetch("text").fetch('*')
      #puts JSON.pretty_generate(donnee)
      donnee = donnee[donnee.index("nowrap")..donnee.index("nowrap")+30]
      donnee = donnee[donnee.index(">")+1..donnee.index("<")-1]

      while(donnee.index("&#"))
        donnee[donnee.index("&#")..donnee.index(";")] = " "
      end
      return donnee + "habitants"

    end
    return false

  end

  #@@API_KEY = 'AIzaSyAzfvWguWlvxRMPI2mFPI-BaW_-ufQxl8o'

  #
  # @param [String] searched city's name
  # @return [Hash] the resulting of this research

  def self.giveData(source, city, departement)
    res = Hash.new

    data = source.fetch("query").fetch("pages").values.first
    pageid = source.fetch("query").fetch("pages").values.first.fetch("pageid").to_s

    if data.key?("revisions") then
      data = data.fetch("revisions").first.fetch("*")

      res["image"] = Hash.new
      res["info"] = Hash.new

      res["city"] = city

      res["desc"] = self.chercheSummary(data)

      if urlPicture = self.cherchePicture(city) != false then
        res["image"]["url"] = self.cherchePicture(city)
      else return self.getWikiInfo(city + " (" + departement + ")", departement) end

      res["info"]["population"] = self.cherchePopulation(pageid)

      tabData = data[1..data.index("'''")].split("| ")

      ["légende", "région", "département", "maire", "cp", "population agglomération", "superficie"].each { |valeur|

        donnee = self.chercheData(tabData, valeur)

        unless donnee.eql?(nil) then
          if donnee.length > 2 then
            if valeur.eql?("légende") then
              res["image"]["desc"] = donnee
            elsif valeur.eql?("superficie") then
              res["info"][valeur] = donnee + "km²"
            elsif valeur.eql?("population agglomération") then
              res["info"][valeur] = donnee + " habitants"
            else res["info"][valeur] = donnee end
          end
        end
      }

      if res.fetch("desc").include?("Unité|habitants") then
        res.fetch("desc")["Unité|habitants"] = res["info"]["population"]
      end

    else
      res["ERROR"] = {'code' => '007', 'message' => "#{city} not found"}
    end
    return res
  end

  def self.getWikiInfo(city, departement)
    url = URI.parse(URI.escape('https://fr.wikipedia.org/w/api.php?action=query&titles=' + city + '&prop=revisions&rvprop=content&rvsection=0&format=json'))
    data = HTTParty.get(url).parsed_response
    return self.giveData(data, city, departement)
  end


end

#https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Paris_-_Eiffelturm_und_Marsfeld2.jpg/1164px-Paris_-_Eiffelturm_und_Marsfeld2.jpg

#rep = Wikipedia.getWikiInfo('Solesmes' , 'Sarthe')

#puts JSON.pretty_generate(rep)
#rep.each { |key, valeur|
#  puts key + ":"
#  p valeur
#}
