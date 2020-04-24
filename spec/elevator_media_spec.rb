 require 'elevator_media/streamer'
 require 'open_weather'
 require 'spec_helper'
 require 'httparty'
 require 'net/http'
 require "rails_helper"
 



 describe ElevatorMedia do

    FAKE_CONTENT_WEATHER = {"coord"=>{"lon"=>-71.21, "lat"=>46.81}, "weather"=>[{"id"=>500, "main"=>"Rain", "description"=>"light rain", "icon"=>"10d"}], "base"=>"stations", "main"=>{"temp"=>5.66, "feels_like"=>-3.14, "temp_min"=>3.89, "temp_max"=>7.22, "pressure"=>994, "humidity"=>80}, "visibility"=>12874, "wind"=>{"speed"=>10.3, "deg"=>190, "gust"=>12.9}, "rain"=>{"1h"=>0.64}, "clouds"=>{"all"=>90}, "dt"=>1587496878, "sys"=>{"type"=>1, "id"=>890, "country"=>"CA", "sunrise"=>1587462324, "sunset"=>1587512465}, "timezone"=>-14400, "id"=>6325494, "name"=>"Québec", "cod"=>200}
    FAKE_CONTENT_CHUCK = { "type": "success", "value": { "id": 432, "joke": "Chuck Norris is the only man who has, literally, beaten the odds. With his fists.", "categories": [] } }
    FAKE_CONTENT_HERO = {"id"=>10, "name"=>"Agent Bob", "slug"=>"10-agent-bob", "powerstats"=>{"intelligence"=>10, "strength"=>8, "speed"=>13, "durability"=>5, "power"=>5, "combat"=>20}, "appearance"=>{"gender"=>"Male", "race"=>"Human", "height"=>["5'10", "178 cm"], "weight"=>["181 lb", "81 kg"], "eyeColor"=>"Brown", "hairColor"=>"Brown"}, "biography"=>{"fullName"=>"Bob", "alterEgos"=>"No alter egos found.", "aliases"=>["Bob", "agent of Hydra", "Bob", "agent of A.I.M"], "placeOfBirth"=>"-", "firstAppearance"=>"Cable & Deadpool #38 (May, 2007)", "publisher"=>"Marvel Comics", "alignment"=>"good"}, "work"=>{"occupation"=>"Mercenary, janitor; former pirate, terrorist", "base"=>"Mobile; formerly Manhattan, Hellcarrier"}, "connections"=>{"groupAffiliation"=>"A.I.M., Deadpool; formerly Agency X, Hydra", "relatives"=>"Allison (ex-wife); Terry and Howie (sons)"}, "images"=>{"xs"=>"https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/images/xs/10-agent-bob.jpg", "sm"=>"https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/images/sm/10-agent-bob.jpg", "md"=>"https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/images/md/10-agent-bob.jpg", "lg"=>"https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/images/lg/10-agent-bob.jpg"}}
  

    describe "Get content from the weather API" do
        
        it "Streamer should respond to getContent method" do
            expect(ElevatorMedia::Streamer).to respond_to(:getContent)
        end

        it "getContent should call/enter the weatherCity method" do
            expect(ElevatorMedia::Streamer).to receive(:weatherCity).with(6325494){FAKE_CONTENT_WEATHER}
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

        it "weatherCity should query the weather api information to be not null, name should equal to Quebec and id should equal to 890" do
            expect(OpenWeather::Current).to receive(:city_id).with(6325494, {:APPID=> ENV['weather_api'], :units=>"metric"}).and_return(FAKE_CONTENT_WEATHER)
            result = ElevatorMedia::Streamer.weatherCity(6325494)
            expect(result).to_not eq(nil)
            expect(result['name']).to eq('Québec') 
            expect(result['sys']['id']).to eq(890)
         end    


        it "getContent with content_type = 'weatherApi', the result should be equal to" do 
            expect(OpenWeather::Current).to receive(:city_id).with(6325494, {:APPID=> ENV['weather_api'], :units=>"metric"}).and_return(FAKE_CONTENT_WEATHER)
            result = ElevatorMedia::Streamer.getContent(6325494, 'weatherApi', '10')
            expect(result).to eq("<html> <body> <div> 
        Town city: Québec, temperature: 5.66 ℃  
        </div> </body> </html> ")
        end


        it "getContent with content_type = 'superHeroApi', the result should be equal to" do
            expect(ElevatorMedia::Streamer).to receive(:superHero).with("10"){FAKE_CONTENT_HERO}
            ElevatorMedia::Streamer.getContent(6325494, 'superHeroApi', "10")
        end
        

        it "getContent with content_type = 'superHeroApi' should return HTML inside a string with the Hero name " do
            expect(ElevatorMedia::Streamer).to receive(:superHero).with('10').and_return(FAKE_CONTENT_HERO)
            result =  ElevatorMedia::Streamer.getContent(6325494, "superHeroApi", '10')
            expect(result).to be_a_kind_of(String)
            expect(result).to include("<html> <body> <div>")
            expect(result).to eq("<html> <body> <div> 
        The super hero of the the day is : Agent Bob 
        </div> </body> </html> ")
        end


        it "getContent with content_type = 'all' should return HTML with all informations" do
                result = ElevatorMedia::Streamer.getContent(6325494, 'all', '10')
                expect(result).to be_a_kind_of(String)
                expect(result).to include("<html> <body> <div>")
                expect(result).to include("Chuck Norris")
                expect(result).to include("The super hero of the the day is")
        end
    end
end

    describe "The api hero" do
        it "the method sould receive the url of the api, from this url a JSON, the JSON should not be null and it should content the FAKE_CONTENT_HERO" do
        plain_json = double("plain_json")    
            expect(Net::HTTP).to receive(:get).with(URI("https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/id/10.json")) {plain_json}    
            expect(JSON).to receive(:parse) {FAKE_CONTENT_HERO}    
                result = ElevatorMedia::Streamer.superHero("10"){FAKE_CONTENT_HERO}
                    expect(result).to_not eq(nil)
                    expect(result).to eq(FAKE_CONTENT_HERO)
        end
    end


    describe "The Chuck Nerris API" do
        it "the method sould receive the url of the api, from this url a JSON, the JSON should not be null and it should content the FAKE_CONTENT_CHUCK" do
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



    RSpec.describe QuotesController, :type => :controller do
        describe "GET submission from quote controller" do
            it "get submission and return a successful response" do
                get :submission
                expect(response).to be_successful
            end
            it "get submission and return 200 status" do
                get :submission
                expect(response.status).to eq(200)
            end
        end
    end




    RSpec.describe PagesController, type: :controller do
        context 'validation test for User' do
            it 'ensures first name presence' do
              user = User.new(lastName: 'Jonathan').save
              expect(user).to eq(false)
            end
    
            it 'ensures last name presence' do
              user = User.new(lastName: 'Murray').save
              expect(user).to eq(false)
            end
    
            it 'ensures email presence' do
              user = User.new(lastName: 'Murray').save
              expect(user).to eq(false)
            end
    
            it 'should save successfully' do 
              user = User.new(firstName: 'Jonathan', lastName: 'Murray', email: 'jonathanmurray1@msn.com').save
              expect(user).to eq(false)
            end
        end

        context 'validation tests for Lead' do

            it "get index pages and return a successful response" do
                get :index
                expect(response).to be_successful
            end

            it "get index pages and return 200 status" do
                get :index
                expect(response.status).to eq(200)
            end

            it 'test the full_name param' do
                lead = Lead.new(full_name: 'Jo').save
                expect(lead).to eq(true)
            end

            it 'test the business_name param' do
                lead = Lead.new(business_name: 'CodeBoxx').save
                expect(lead).to eq(true)
            end

            it 'test the email param' do
                lead = Lead.new(email: 'jonathanmurray1@msn.com').save
                expect(lead).to eq(true)
            end

            it 'test the phone param' do
                lead = Lead.new(phone: '555-555-5555').save
                expect(lead).to eq(true)
            end

            it 'test the project_name param' do
                lead = Lead.new(project_name: 'Alpha').save
                expect(lead).to eq(true)
            end

            it 'test the project_description param' do
                lead = Lead.new(project_description: 'Delta').save
                expect(lead).to eq(true)
            end

            it 'test the department param' do
                lead = Lead.new(department: 'Residential').save
                expect(lead).to eq(true)
            end

            it 'test the message param' do
                lead = Lead.new(message: 'message').save
                expect(lead).to eq(true)
            end
        end
    end



    RSpec.describe InterventionsController, type: :controller do

        context 'validation tests for Intervention' do

            it "get intervention and return a successful response" do
                get :interventions
                    expect(response).to be_successful
            end

            it "get intervention and return 200 status" do
                get :interventions
                    expect(response.status).to eq(200)
            end
        end
            context 'validation tests for DB Intervention' do

            it "send a customer_id to the building method and return succesful" do
                building = Building.new(customer_id: 2)
                    expect(response).to be_successful
                    expect(response.status).to eq(200)
            end


            it "send a customer_id to the building method and return succesful" do
                buildingObject = Battery.new(building_id: 5).save
                    expect(response).to be_successful
                    expect(response.status).to eq(200)
            end
            

            it "send a customer_id to the building method and return succesful" do
                building = Column.new(battery_id: 5).save
                    expect(response).to be_successful
                    expect(response.status).to eq(200)
            end
            

            it "send a customer_id to the building method and return succesful" do
                building = Elevator.new(column_id: 6).save
                    expect(response).to be_successful
                    expect(response.status).to eq(200)
            end

            it 'should return an error (false) some params are not entered' do
                intervention = Intervention.new(author_id: 1, customer_id: 2).save
                    expect(intervention).to eq(false)
            end

            it 'should return an error (false) if the parameter customer_id is not entered' do
                intervention = Intervention.new(author_id: 1, building_id: 4, battery_id: 10, 
                column_id: 5, elevator_id: 40, employee_id: 5, report: "This is report"  ).save
                    expect(intervention).to eq(false)
            end

            it 'should return good (true) without emplotee_id param' do
                intervention = Intervention.new(author_id: 1, customer_id: 2, building_id: 4, battery_id: 10, 
                column_id: 5, elevator_id: 40, report: "This is report"  ).save
                    expect(intervention).to eq(true)
            end
            
            it 'should return good (true) even without elevator_id, column_id and battery_id ' do
                intervention = Intervention.new(author_id: 1, customer_id: 2, building_id: 4, battery_id: 10,
                employee_id: 5, report: "This is report").save
                    expect(intervention).to eq(true)
            end
            
            it 'should return good (true) even witouh elevator_id and column_id' do
                intervention = Intervention.new(author_id: 1, customer_id: 2, building_id: 4, battery_id: 10, 
                employee_id: 5, report: "This is report").save
                    expect(intervention).to eq(true)
            end

            it 'should return good (true) even witouh elevator_id and column_id and employee_id' do
                intervention = Intervention.new(author_id: 1, customer_id: 2, building_id: 4, battery_id: 10, 
                report: "This is report").save
                    expect(intervention).to eq(true)
            end

            it 'should return good (true) if ALL params are there' do
                intervention = Intervention.new(author_id: 1, customer_id: 2, building_id: 4, battery_id: 10, 
                column_id: 5, elevator_id: 40, employee_id: 5, report: "This is report"  ).save
                    expect(intervention).to eq(true)
                  #  expect(intervention).to have_attributes(:author_id => 1)
            end
        end
    end
            # context 'Get building method' do
            #       it 'returns a success response' do
            #         get :building
            #         expect(response).to be_success
            #     end
         
            #     it 'get building method with param' do
            #         intervention = Intervention.new(author_id: 1, customer_id: 2, building_id: 4, battery_id: 10, 
            #         column_id: 5, elevator_id: 40, employee_id: 5, report: "This is report"  )
            #             get :building, params: { id: intervention.to_param }
            #         expect(response).to be_success
            #     end
            # end
  
RSpec.describe "Routes", :type => :routing do

            it "routes to get the  home page" do
            expect(get: "/home").to route_to("pages#home")
            end

            it "routes to post the created lead" do
            expect(post: "/index").to route_to("pages#create")
            end

            it "routes for the IbmWatson to send the information to IBM Watson" do
            expect(post: "/root").to route_to("root#sendInformation")
            end
    

            it "routes to get the corporate page" do
            expect(get: "/corporate").to route_to("pages#corporate")
            end

            it "routes to get the residential page" do
            expect(get: "/residential").to route_to("pages#residential")
            end

            it "routes to get the submission page" do
            expect(get: "/submission").to route_to("quotes#submission")
            end
          
            it "routes to when post method is called in quote page" do
            expect(post: "/submission").to route_to("quotes#create")
            end
     
            it "routes to get the employee page" do
            expect(get: "/employee").to route_to("pages#employee")
            end
    
            it "routes to index " do
            expect(get: "/index").to route_to("pages#index")
            end
  
            it "routes to  user index" do
            expect(get: "/users/index").to route_to("pages#index")
            end

            it "routes to #index" do
            expect(get: "dashboard").to route_to("pages#dashboard")
            end

            it "routes to #index" do
            expect(get: "dashboard").to route_to("pages#dashboard")
            end


          
            # post 'interventions' => 'interventions#create'
            # get 'interventions' => 'interventions#interventions'
          
            # get 'interventions/building' => 'interventions#building'
            # get 'interventions/battery' => 'interventions#battery'
            # get 'interventions/column' => 'interventions#column'
            # get 'interventions/elevator' => 'interventions#elevator'

    end

    
    #   RSpec.describe "AdminPanel", :type => :feature do
    #     context "Go to admin panel" do
    #         it "Lets me go" do
    #             visit 'users/sign_in'
    #             fill_in "Email", with: 'nimportequellemail@hotmail.com'
    #             fill_in "Password", with: '123456'
    #          end
    #      end
    #  end

