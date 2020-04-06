module ZendeskModule
  class ZendeskClass
    def ticket_new
      # SOME CODE
      # doesn't actually send a request, must explicitly call #save!
      ZendeskAPI::Ticket.new(client, :id => 1, :priority => "urgent")
      ZendeskAPI::Ticket.create!(client, :subject => "Test Ticket", :comment => { :value => "This is a test" }, :submitter_id => client.current_user.id, :priority => "urgent")
      ZendeskAPI::Ticket.find!(client, :id => 1)
      ZendeskAPI::Ticket.destroy!(client, :id => 1)
    end

    puts "hello" # For testing with the console

    def method_name
      # SOME CODE
    end
  end
end
