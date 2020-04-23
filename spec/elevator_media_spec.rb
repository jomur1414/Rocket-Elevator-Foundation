 require 'elevator_media/streamer'

 require 'open_weather'
 require 'spec_helper'
 require 'httparty'
 require 'net/http'




 describe ElevatorMedia do

    FAKE_CONTENT_WEATHER = {"coord"=>{"lon"=>-71.21, "lat"=>46.81}, "weather"=>[{"id"=>500, "main"=>"Rain", "description"=>"light rain", "icon"=>"10d"}], "base"=>"stations", "main"=>{"temp"=>5.66, "feels_like"=>-3.14, "temp_min"=>3.89, "temp_max"=>7.22, "pressure"=>994, "humidity"=>80}, "visibility"=>12874, "wind"=>{"speed"=>10.3, "deg"=>190, "gust"=>12.9}, "rain"=>{"1h"=>0.64}, "clouds"=>{"all"=>90}, "dt"=>1587496878, "sys"=>{"type"=>1, "id"=>890, "country"=>"CA", "sunrise"=>1587462324, "sunset"=>1587512465}, "timezone"=>-14400, "id"=>6325494, "name"=>"Québec", "cod"=>200}
    FAKE_CONTENT_CHUCK = { "type": "success", "value": { "id": 432, "joke": "Chuck Norris is the only man who has, literally, beaten the odds. With his fists.", "categories": [] } }
    FAKE_CONTENT_HERO = {"id"=>10, "name"=>"Agent Bob", "slug"=>"10-agent-bob", "powerstats"=>{"intelligence"=>10, "strength"=>8, "speed"=>13, "durability"=>5, "power"=>5, "combat"=>20}, "appearance"=>{"gender"=>"Male", "race"=>"Human", "height"=>["5'10", "178 cm"], "weight"=>["181 lb", "81 kg"], "eyeColor"=>"Brown", "hairColor"=>"Brown"}, "biography"=>{"fullName"=>"Bob", "alterEgos"=>"No alter egos found.", "aliases"=>["Bob", "agent of Hydra", "Bob", "agent of A.I.M"], "placeOfBirth"=>"-", "firstAppearance"=>"Cable & Deadpool #38 (May, 2007)", "publisher"=>"Marvel Comics", "alignment"=>"good"}, "work"=>{"occupation"=>"Mercenary, janitor; former pirate, terrorist", "base"=>"Mobile; formerly Manhattan, Hellcarrier"}, "connections"=>{"groupAffiliation"=>"A.I.M., Deadpool; formerly Agency X, Hydra", "relatives"=>"Allison (ex-wife); Terry and Howie (sons)"}, "images"=>{"xs"=>"https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/images/xs/10-agent-bob.jpg", "sm"=>"https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/images/sm/10-agent-bob.jpg", "md"=>"https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/images/md/10-agent-bob.jpg", "lg"=>"https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/images/lg/10-agent-bob.jpg"}}
  
  
    
  
    # Test for Open Weather api

    # context "get something from api" do
    #     it "should at least return something" do
    #         expect(ElevatorMedia::Streamer.weatherCity(6325494)).to_not eq(nil)
    #     end
    # end

    # context "test for string" do
    #     it 'return type string' do
    #         expect(ElevatorMedia::Streamer.getContent(6325494)).to be_a(String)
    #     end
    # end

    # context "test for div" do
    #     it 'should include div' do
    #     expect(ElevatorMedia::Streamer.getContent(6325494)).to include('<div>')
    #     end
    # end

      # context "get Quebec city" do
    #      it "Should return the city named Québec" do
    #          expect(ElevatorMedia::Streamer.weatherCity(6325494)['name']).to eq('Québec')
    #      end
    #  end

    #  context "get Quebec city" do
    #     it "Should return the city named Montreal" do
    #         expect(ElevatorMedia::Streamer.weatherCity(6077243)['name']).to eq('Montreal')
    #     end
    # end

    # context "get something from the tempereture" do
    #     it "should at least return non null value" do
    #         expect(ElevatorMedia::Streamer.weatherCity(6325494)['main']['temp']).to_not eq(nil)
    #     end
    # end


   # REAL TEST

    describe "Get content from the weather API" do
        it "Streamer should respond to getContent method" do

            expect(ElevatorMedia::Streamer).to respond_to(:getContent)

        end

        it "getContent should call/enter the weatherCity method" do

            expect(ElevatorMedia::Streamer).to receive(:weatherCity).with(6325494) {FAKE_CONTENT_WEATHER}
            ElevatorMedia::Streamer.getContent(6325494, 'weatherApi', "10")
        end

        it "getContent from apiWeather should be non null" do

            expect(OpenWeather::Current).to receive(:city_id).with(6325494, {:APPID=> ENV['weather_api'], :units=>"metric"}).and_return(FAKE_CONTENT_WEATHER)
            result = ElevatorMedia::Streamer.getContent(6325494, 'weatherApi', '10')
            expect(result).to_not be_nil
        end

        it "getContent from apiWeather should be a string" do 
            expect(OpenWeather::Current).to receive(:city_id).with(6325494, {:APPID=> ENV['weather_api'], :units=>"metric"}).and_return(FAKE_CONTENT_WEATHER)
            result = ElevatorMedia::Streamer.getContent(6325494, 'weatherApi', '10')
            expect(result).to be_a(String)
        end

        it "should query the weather api information" do
            expect(OpenWeather::Current).to receive(:city_id).with(6325494, {:APPID=> ENV['weather_api'], :units=>"metric"}).and_return(FAKE_CONTENT_WEATHER)
            result = ElevatorMedia::Streamer.weatherCity(6325494)
            expect(result).to_not eq(nil)
            expect(result['name']).to eq('Québec') 
            expect(result['sys']['id']).to eq(890)
         end
        end


        it "getContent from apiWeather result should be" do 
            expect(OpenWeather::Current).to receive(:city_id).with(6325494, {:APPID=> ENV['weather_api'], :units=>"metric"}).and_return(FAKE_CONTENT_WEATHER)
            result = ElevatorMedia::Streamer.getContent(6325494, 'weatherApi', '10')
            expect(result).to eq("<html> <body> <div> 
        Town city: Québec, temperature: 5.66 ℃  
        </div> </body> </html> ")
        end


        it "getContent should call the superHero method" do

            expect(ElevatorMedia::Streamer).to receive(:superHero).with("10") {FAKE_CONTENT_HERO}
            ElevatorMedia::Streamer.getContent(6325494, 'superHeroApi', "10")

        end


        it "getContent should return HTML inside a string with the Hero name " do

            expect(ElevatorMedia::Streamer).to receive(:superHero).with('10') {FAKE_CONTENT_HERO}
            result =  ElevatorMedia::Streamer.getContent(6325494, "superHeroApi", '10') {FAKE_CONTENT_HERO}
            expect(result).to be_a_kind_of(String)
            expect(result).to include("<html> <body> <div>")
            expect(result).to eq("<html> <body> <div> 
        The super hero of the the day is : Agent Bob 
        </div> </body> </html> ")

        end
 
        it "return HTML inside a string" do
                expect(OpenWeather::Current).to receive(:city_id).with(6325494, {:units=>"metric", :APPID=> ENV['weather_api']}).and_return(FAKE_CONTENT_WEATHER)
                result = ElevatorMedia::Streamer.getContent(6325494, 'all', '10')
                expect(result).to be_a_kind_of(String)
                expect(result).to include("<html> <body> <div>")
                expect(result).to include("Chuck Norris")
    
        end
    end
        

    describe "Get superHero method" do
        it "return a Hero" do

        plain_json = double("plain_json")    
        expect(Net::HTTP).to receive(:get).with(URI("https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/id/10.json")) {plain_json}    
        expect(JSON).to receive(:parse) {FAKE_CONTENT_HERO}    
        result = ElevatorMedia::Streamer.superHero("10"){FAKE_CONTENT_HERO}
        expect(result).to_not eq(nil)
        expect(result).to eq(FAKE_CONTENT_HERO)

        end
    end


    describe "Get chuck norris" do
        it "return joke of the day" do

        plain_json = double("plain_json")    
        expect(Net::HTTP).to receive(:get).with(URI("http://api.icndb.com/jokes/random")) {plain_json}    
        expect(JSON).to receive(:parse) {FAKE_CONTENT_CHUCK}    
        result = ElevatorMedia::Streamer.chuckNorris(){FAKE_CONTENT_CHUCK}
        expect(result).to_not eq(nil)
        expect(result).to eq(FAKE_CONTENT_CHUCK)

        end
    end

    # describe "Test de content" do
    #     it "Get the content" do
    #         expect(ElevatorMedia::Streamer.getContent(6325494, 'weatherApi', '10')).to_not eq(nil)
    #          expect(ElevatorMedia::Streamer.getContent(6325494, 'chuckApi', '10')).to_not eq(nil)
    #         expect(ElevatorMedia::Streamer.getContent(6325494, 'superHeroApi', '10')).to_not eq(nil)
    #            expect(ElevatorMedia::Streamer.getContent(6325494, 'all', '10')).to_not eq(nil)
    #     end
    # end




#     RSpec.describe InterventionsController, type: :model do
#         context 'validation tests' do
#           it 'ensures first name presence' do
#             user = User.new(last_name: 'Last', email: 'sample@example.com').save
#             expect(user).to eq(false)
#           end
#     end
# end


