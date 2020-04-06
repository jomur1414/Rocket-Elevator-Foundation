


#frozen_string_literal: true

require "json"
require "ibm_watson/authenticators"
require "ibm_watson/text_to_speech_v1"

module WatsonApi
    
  class WatsonTextToSpeech
    
    include IBMWatson


    # def initialize      
      
    #    @auth = IBMWatson::Authenticators::IamAuthenticator.new(apikey: ENV['watson_api'])
    #    @text_to_speech = IBMWatson::TextToSpeechV1.new(authenticator: authenticator)
    #    @text_to_speech.service_url = ENV['watson_url']

    #  end

    def call(name, numberOfElevator, nbOfBuilding, nbOfCustomers, nbofDisabledElevator, numberOfQuote, nbOfLeads, nbOfBatteries, nbOfCities ) 

      authenticator = IBMWatson::Authenticators::IamAuthenticator.new(
          apikey: ENV['watson_api']
      )
      text_to_speech = IBMWatson::TextToSpeechV1.new(
          authenticator: authenticator
      )
      
    # puts JSON.pretty_generate(text_to_speech.list_voices.result)

      text_to_speech.service_url = ENV['watson_url']


      tmp_file = "#{Rails.root}/public/tmp_file.wav"

      File.open(tmp_file, "wb") do |audio_file|

        response = text_to_speech.synthesize(
            {
              "text":"Greetings #{name}. There are currently #{numberOfElevator} elevators deployed in the #{nbOfBuilding} buildings 
              of yours #{nbOfCustomers} customers. Currently, #{nbofDisabledElevator} elevators are in Running Status and are being serviced. 
              You currently have #{numberOfQuote} quotes awaiting in processing.
              You currently have #{nbOfLeads} leads in your contact requests.
              #{nbOfBatteries} batteries are deployed across your #{nbOfCities} cities",
              "accept": "audio/wav",
              "voice": "en-US_AllisonVoice"
            }
        ).result

        audio_file << response

      end
    end
  end
end






# module WatsonApi

#     class WatsonTextToSpeech

#     authenticator = IBMWatson::Authenticators::IamAuthenticator.new(
#     apikey: ENV['watson_api']
#     )

#     text_to_speech = IBMWatson::TextToSpeechV1.new(
#     authenticator: authenticator
#     )

#     text_to_speech.service_url = ENV['watson_url']


#     tmp_file = "#{Rails.root}/app/assets/audios/watsonsound.wav"

#     File.open(tmp_file, "wb") do |audio_file|

#     response = text_to_speech.synthesize(
#         {"text": "Hello",
#         "accept": "audio/wav",
#         "voice": "en-US_AllisonVoice"
#     }
#     ).result

#     audio_file << response

# end
# end
# end
