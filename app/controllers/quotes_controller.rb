class QuotesController < ApplicationController
  def submission
  end
  def create
    
    #Quote.create(params)
    @quote = Quote.new
    @quote = Quote.create(
      firstName: params[:fullName],
      phoneNumber: params[:phoneNumber],
      companyName: params[:companyName],
      email: params[:email],
      buildingType: params[:departmentSelector],
      productGrade: params[:quality],
      nbAppartment: params[:apartment],
      nbBusiness: params[:companie],
      nbFloor: params[:floor],
      nbBasement: params[:basement],
      nbCage: params[:cage],
      nbParking: params[:parking],
      nbOccupantFloor: params[:occupant],
      nbOperatingHours: params[:activity],
      nbElevatorNeeded: params[:elevator_needed],
      instllationCost: params[:installation_cost],
      totalCost: params[:total_cost],
    )
    @client = ZendeskAPI::Client.new do |config|
      config.url = "https://zendeskmurrayjonathan.zendesk.com/api/v2" # e.g. https://mydesk.zendesk.com/api/v2
      # Basic / Token Authentication
      config.username = "jonathanmurray1@msn.com"
      # config.token = "Zendesk_Token"
      config.token = ENV["zendesk_token_foundation"]
    end
    ZendeskAPI::Ticket.create!(@client,
      :subject => "#{@quote.firstName} from #{@quote.companyName}",
      :description => "Create Ticket",
      :comment =>{ :value =>
      "The contact #{@quote.firstName} from company #{@quote.companyName} can be reached at email #{@quote.email} and at phone number #{@quote.phoneNumber}. The #{@quote.buildingType} department has a project that would require contribution from Rocket Elevators."},
      :type => 'task',
      :priority => "urgent")
  end
    #ON SEND ->
    if @quote.try(:save!)
      @quote.ticket_quote
      redirect_to "/submission"
    end
  end 
