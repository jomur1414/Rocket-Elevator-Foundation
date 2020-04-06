# Download the twilio-ruby library from twilio.com/docs/libraries/ruby
require 'twilio-ruby'
require 'sinatra'

get '/' do
    "Hello World"
end

post '/sms-quickstart' do
    twiml = Twilio::TwiML::MessagingResponse.new do |r|
        r.message(body: 'Ahoy! Thanks so much for your message.')
    end

    twiml.to_s
end
