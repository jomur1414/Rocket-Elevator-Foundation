require'pg'
require'faker'


# TASK FOR CREATION OF DB AND TABLE IN postgresql
task create_pg_table: :environment do
# In terminal: $ rake create_pg_table
#conn = PG::Connection.open(host: "localhost", port: 5432, dbname:"rocket_elevators_information_system_development_psql", user:"postgres", password:"root")
# conn = PG.connect("host=codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com port=5432 dbname=jonathanMurray user=codeboxx password=Codeboxx1!");
conn = PG::Connection.open(host: "localhost", port: 5432, dbname:"postgres", user:"postgres", password:"poiu")

conn.exec("
CREATE TABLE factquotes(
      quote_id INT PRIMARY KEY,
      creation_date DATE  NOT NULL,
      business_name VARCHAR (355) NOT NULL,
      email VARCHAR (355) NOT NULL,
      nb_elevator INT NOT NULL
   );
   CREATE TABLE factcontact(
      contact_id INT PRIMARY KEY,
      creation_date DATE  NOT NULL,
      business_name VARCHAR (355) NOT NULL,
      email VARCHAR (355) NOT NULL,
      procject_name VARCHAR (355) NOT NULL
   );
   CREATE TABLE factelevator(
      serial_number BIGINT PRIMARY KEY,
      commissioning_date DATE  NOT NULL,
      building_id INT NOT NULL,
      customer_id INT NOT NULL,
      city VARCHAR (355) NOT NULL
   );
   CREATE TABLE dimcustomers(
      creation_date DATE  NOT NULL,
      business_name VARCHAR (355) NOT NULL,
      full_user_name VARCHAR (355) NOT NULL,
      email VARCHAR (355)  NOT NULL,
      number_elevators INT NOT NULL,
      city VARCHAR (355) NOT NULL
   );
   ")
end



   desc "Data transfert"
# In terminal: $ rake transfer_for_fact
   task transfer_for_fact: :environment do

      #   conn = PG::Connection.open(host: "localhost", port: 5432, dbname:"rocket_elevators_information_system_development_psql", user:"postgres", password:"root")
         # conn = PG.connect("host=codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com port=5432 dbname=jonathanMurray user=codeboxx password=Codeboxx1!");
         conn = PG::Connection.open(host: "localhost", port: 5432, dbname:"postgres", user:"postgres", password:"poiu")

      conn.exec ("TRUNCATE factquotes RESTART IDENTITY")
      Quote.all.each do |quote|
      conn.exec( "INSERT INTO factquotes (quote_id, creation_date, business_name, email, nb_elevator )
         VALUES (#{quote.id}, '#{quote.created_at}', '#{quote.companyName}', '#{quote.email}', '#{quote.nbElevatorNeeded}')")

      end
 

      conn.exec ("TRUNCATE factcontact RESTART IDENTITY")
      Lead.all.each do |lead|
      conn.exec( "INSERT INTO factcontact (contact_id, creation_date, business_name, email, procject_name )
      VALUES (#{lead.id}, '#{lead.created_at}', '#{lead.business_name}', '#{lead.email}', '#{lead.project_name}')")
      end


   conn.exec ("TRUNCATE factelevator RESTART IDENTITY")
   Elevator.all.each do |elevator|
   conn.exec( "INSERT INTO factelevator (serial_number, commissioning_date, building_id, customer_id, city )
      VALUES (#{elevator.serial_number}, '#{elevator.date_service_since}', '#{elevator.column.battery.building.id}', '#{elevator.column.battery.building.customer_id}', '#{elevator.column.battery.building.address.city}')")

      end

         
   conn.exec ("TRUNCATE dimcustomers RESTART IDENTITY")

   Customer.all.each do |customer|

      nbElevator = 0

      customer.buildings.all.each do |building|
         
            building.batteries.all.each do |battery|
            
               battery.columns.all.each do |column|
               
               nbElevator += column.elevators.count
                     
               end
            end
      end
   
   conn.exec( "INSERT INTO dimcustomers (creation_date, business_name, full_user_name, email, number_elevators, city )
      VALUES ('#{customer.created_at}', '#{customer.business_name}', '#{customer.contact_full_name}', '#{customer.contact_email}',  '#{nbElevator}', '#{customer.address.city}')")

   end
end




task create_fact_intervention: :environment do
desc "Create Fact Intervention Table"
# In terminal: $ rake create_fact_intervention


conn = PG.connect("host=codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com port=5432 dbname=jonathanMurray user=codeboxx password=Codeboxx1!");
   conn.exec("
   CREATE TABLE FactIntervention(
      employee_ID INT,
      building_id INT,
      battery_id INT,
      column_id INT,
      elevator_ID INT,
      start_date_time_intervention TIMESTAMP,
      end_date_time_intervention TIMESTAMP,
      result VARCHAR (355),
      report VARCHAR (355),
      status VARCHAR (355)
      );
   ")
end


# In terminal: $ rake data_fact_intervention
task data_fact_intervention: :environment do
desc "Send data to Fact Intervention Table"

conn = PG.connect("host=codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com port=5432 dbname=jonathanMurray user=codeboxx password=Codeboxx1!");
   conn.exec ("TRUNCATE factintervention RESTART IDENTITY")
# faire un rand 0-4 = x
# status[x]
   intervention = Elevator.where(status: 'Intervention')
   intervention.all.each do |elevator|

      x = rand(0..2)
      result = ['success', 'echec', 'incomplete']
      result = result[x]

      dateStart = Faker::Time.between(from: DateTime.now - 5, to: DateTime.now, format: :default)
      dateEnd = Faker::Time.between(from: DateTime.now - 2, to: DateTime.now, format: :default)
      report = ''


      if result == 'incomplete' then
         y = rand(0..2)
         status = ['pending', 'inProgress', 'interrupted']
         status = status[y]
         dateEnd = dateStart

      elsif result == 'echec' then
         y = rand(0..2)
         status = ['inProgress', 'interrupted', 'resumed']
         status = status[y]
         dateEnd = dateStart

      elsif result == 'success' then
         status = 'complete'
      end


      conn.exec("
                  INSERT INTO
                     factintervention (elevator_id,
                                       column_id,
                                       battery_id,
                                       building_id,
                                       employee_id,
                                       start_date_time_intervention,
                                       end_date_time_intervention,
                                       result,
                                       report,
                                       status
                                       )
                  VALUES
                     ('#{elevator.id}',
                     '#{elevator.column.id}',
                     '#{elevator.column.battery.id}',
                     '#{elevator.column.battery.building.id}',
                     '#{elevator.column.battery.employee.id}',
                     '#{dateStart}',
                     '#{dateEnd}',
                     '#{result}',
                     '#{report}',
                     '#{status}'
                     )
               ")
   end
end