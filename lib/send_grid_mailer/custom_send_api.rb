
require 'sendgrid-ruby'
require 'json'
# include 'figaro'


module SendGridApi

    class CustomSendGrid
      include SendGrid
      def initialize
        @mail = SendGrid::Mail.new
        @mail.from = Email.new(email: 'codeBoxx@codeboxx.biz')
        @sg = SendGrid::API.new(api_key: ENV['valeur_api_sendgrid'], host: 'https://api.sendgrid.com')

      end

      def basic_mail(subject, to, message)
        @mail.subject = "#{subject}" 
        personalization = Personalization.new
        personalization.add_to(Email.new(email: "#{to}"))
        @mail.add_personalization(personalization)

        
        @mail.add_content(Content.new(type: 'text/html', value: "#{message}"))

        attachment = Attachment.new
        attachment.content = Base64.strict_encode64(File.open('app/assets/images/header_logo.png', 'rb').read)
        attachment.type = 'image/png'
        attachment.filename = 'rocketBuild.png'
        attachment.disposition = 'attachment'
        attachment.content_id = 'monImage'
        @mail.add_attachment(attachment)

        # attachment2 = Attachment.new
        # attachment2.content = File.read('images/rocket.png')
        # attachment2.type = 'image/png'
        # attachment2.filename = ("rocketBuild.png")
        # attachment2.disposition = 'inline'
        # attachment2.content_id = 'Banner'
        puts @mail.to_json
        response = @sg.client.mail._('send').post(request_body: @mail.to_json)
        puts response.status_code
        puts response.body
        puts response.headers

      end
    end
  end




  #  mail = SendGridMailer::Mailer.new
  #  subject = "Leads create"
  #  to = "jonathanmurray1@msn.com"
  #  message = "test message with image"
  #  mail.basic_mail(subject, to, message)


