# Download the twilio-ruby library from twilio.com/docs/libraries/ruby
require 'twilio-ruby'

module SendSms
    class Sms
        def initialize
        end

        def send_sms(technician)
            account_sid = ENV['twilio_account_id']
            auth_token = ENV['twilio_auth_token']
            client = Twilio::REST::Client.new(account_sid, auth_token)
    
            from = ENV['twilio_number'] # Your Twilio number
            to = ENV['twilio_my_phone_number'] # Your mobile phone number
    
            client.messages.create(
            from: from,
            to: to,
            body: "Hi, a new intervention is requested. Please contact #{technician}."
            )            
        end
    end
end
