class InterventionsController < ApplicationController


    def building
        if params[:customer].present?
            @building = Building.where(customer_id:params[:customer])
        else
            @building = Building.all
        end

        respond_to do |format|
            format.json {
                render json: {building: @building}
            }
        end
    end

    def battery
        if params[:building].present?
            @battery = Battery.where(building_id:params[:building])
        else
            @battery = Battery.all
        end

        respond_to do |format|
            format.json {
                render json: {battery: @battery}
            }
        end
    end

    def column
        if params[:battery].present?
            @column = Column.where(battery_id:params[:battery])
        else
            @column = Column.all
        end

        respond_to do |format|
            format.json {
                render json: {column: @column}
            }
        end
    end

    def elevator
        if params[:column].present?
            @elevator = Elevator.where(column_id:params[:column])
        else
            @elevator = Elevator.all
        end

        respond_to do |format|
            format.json {
                render json: {elevator: @elevator}
            }
        end
    end


#to author_id use current_user_id ?

    def create
        @current_user_id = current_user.id

        if params[:column] == "None"
            params[:column] = nil
        end

        if params[:elevator] == "None"
            params[:elevator] = nil
         end
        
            @intervention = Intervention.new

            @intervention = Intervention.create(
                author_id: @current_user_id,
                customer_id: params[:customer],
                building_id: params[:building],
                battery_id: params[:battery],
                column_id: params[:column],
                elevator_id: params[:elevator],
                employee_id: params[:employee],
                report: params[:report]

                
                
            )
            redirect_to "/interventions"

    zendesk();
end


def zendesk()

    @nameauthor = current_user.firstName
    @client = ZendeskAPI::Client.new do |config|
    config.url = "https://zendeskmurrayjonathan.zendesk.com/api/v2" # e.g. https://mydesk.zendesk.com/api/v2
    # Basic / Token Authentication
    config.username = "jonathanmurray1@msn.com"
    # config.token = "Zendesk_Token"
    config.token = ENV["zendesk_token_foundation"]
  end




  ZendeskAPI::Ticket.create!(@client,
  :subject => "Intervention ticket author: #{@nameauthor} from customer #{@intervention.customer.contact_full_name}",
  :description => "Create Ticket Intervention",
  :comment =>{ :value =>
  "Building id #{@intervention.building_id} 
  \n \n  Battery id  #{@intervention.battery_id} 
  \n \n  Column id #{@intervention.column_id} 
  \n \n  Elevator #{@intervention.elevator_id }
  \n \n  Employee assigned to do the intervention :  #{@intervention.employee_id}
   \n \n Intervention description:  #{@intervention.report}"},
  :type => 'problem',
  :priority => "urgent")
  
end






end
