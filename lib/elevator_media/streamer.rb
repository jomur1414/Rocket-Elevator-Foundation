
module ElevatorMedia
class Streamer

require 'open_weather'
require 'json'
require 'httparty'
require 'net/http'
    

    def self.getContent(city_id, content_type, idSuperHero)


        weather = self.weatherCity(city_id)

        chuck = self.chuckNorris()

        superHero = self.superHero(idSuperHero)

        if content_type == 'weatherApi'

        information = "<html> <body> <div> 
        Town city: #{weather['name']}, temperature: #{weather['main']['temp']} ℃  
        </div> </body> </html> "
        
        end
   
        if content_type == 'chuckApi'

        information = "<html> <body> <div> 
        The Chuck Norris joke of the day is: #{chuck['value']['joke']}  
        </div> </body> </html> "
        
        end
    
        if content_type == 'superHeroApi'

        information = "<html> <body> <div> 
        The super hero of the the day is : #{superHero['name']} 
        </div> </body> </html> "
        
        end

        if content_type == 'all'
        
        information = "<html> <body> <div> 
        Town city: #{weather['name']}, temperature: #{weather['main']['temp']} ℃  
        The Chuck Norris joke of the day is: #{chuck['value']['joke']}  
        The super hero of the the day is : #{superHero['name']} 
        </div> </body> </html> "

        end

    
        return information

    end


    # 876428adbfcd109c539080c03f050b28
    def self.weatherCity(city_id)

        options = { units: "metric", APPID: ENV['weather_api']}
        city = (OpenWeather::Current.city_id(city_id, options))
        return city

    end


    def self.chuckNorris()

        uritest =  Net::HTTP.get(URI('http://api.icndb.com/jokes/random'))
        obj_chuck = JSON.parse(uritest)

        # url = URI.parse('http://api.icndb.com/jokes/random')
        # req = Net::HTTP::Get.new(url.to_s)
        # res = Net::HTTP.start(url.host, url.port) {|http| http.request(req) }
   
        # res.body

        # obj = JSON.parse(res.body)
    
        return obj_chuck        
    end

    def self.superHero(id)

        # id = 10.to_s
        uritest =  Net::HTTP.get(URI("https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/id/#{id}.json"))
        obj_hero = JSON.parse(uritest)
        return obj_hero

    end



end
end





#{"coord"=>{"lon"=>-71.21, "lat"=>46.81}, "weather"=>[{"id"=>500, "main"=>"Rain", "description"=>"light rain", "icon"=>"10d"}], "base"=>"stations", "main"=>{"temp"=>5.66, "feels_like"=>-3.14, "temp_min"=>3.89, "temp_max"=>7.22, "pressure"=>994, "humidity"=>80}, "visibility"=>12874, "wind"=>{"speed"=>10.3, "deg"=>190, "gust"=>12.9}, "rain"=>{"1h"=>0.64}, "clouds"=>{"all"=>90}, "dt"=>1587496878, "sys"=>{"type"=>1, "id"=>890, "country"=>"CA", "sunrise"=>1587462324, "sunset"=>1587512465}, "timezone"=>-14400, "id"=>6325494, "name"=>"Québec", "cod"=>200}

# https://stackoverflow.com/questions/1826727/how-do-i-parse-json-with-ruby-on-rails
# https://github.com/coderhs/ruby_open_weather_map


# get current weather by city name
# OpenWeather::Current.city("Cochin, IN", options)

# # get current weather by city id
# OpenWeather::Current.city_id("1273874", options)

# get current weather by city name
# options = { units: "metric", APPID: "1111111111" }
# OpenWeather::Current.city("Berlin, DE", options)