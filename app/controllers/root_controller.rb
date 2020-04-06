
class RootController < ApplicationController


require 'watson/watson_api'

  def sendInformation

    # WatsonApi::WatsonTextToSpeech.new
 
    name = current_user.firstName
    numberOfElevator = Elevator.count  
    nbOfBuilding =  Building.count
    nbOfCustomers = Customer.count
    nbofDisabledElevator = Elevator.where(:status=>"Inactive").count
    numberOfQuote = Quote.count
    nbOfLeads = Lead.count
    nbOfBatteries = Battery.count
    nbOfCities = Address.distinct.count(:city)
    WatsonApi::WatsonTextToSpeech.new.call(name, numberOfElevator, nbOfBuilding, nbOfCustomers, nbofDisabledElevator, numberOfQuote, nbOfLeads, nbOfBatteries, nbOfCities  )

    end



end

