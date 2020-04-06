require 'http'
require 'json'
require 'send_sms/sms'

class Elevator < ApplicationRecord
include ActiveModel::Dirty
belongs_to :column
    
    after_update :slack_status_alert, :send_sms

    def slack_status_alert
        if previous_changes[:status] !=nil
            rc = HTTP.post("https://slack.com/api/chat.postMessage", params: {
                token: ENV['slack_app_id'],
                channel: '#elevator_operations',
                text: 'The Elevator '+(id.to_s)+' with Serial Number '+ (serial_number.to_s) +' changed status from '+previous_changes[:status][0]+' to '+status+''
            })
            puts JSON.pretty_generate(JSON.parse(rc.body))
        end
    end 

    def send_sms()
        status = self.status
        s = status.downcase
        if s == 'intervention'
            t = self.column.battery.building.customer.technician_full_name
            sms = SendSms::Sms.new
            sms.send_sms(t)
        else
            puts "Elevator status is #{self.status}"
        end
    end

end
