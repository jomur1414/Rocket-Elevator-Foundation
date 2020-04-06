require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
puts '-----------------------------------------------------------------------------'
puts 'If NoMethodError: undefined method email for nil:NilClass
      go to the model/customer and comment the line => after_create :upload_lead_files'
puts '-----------------------------------------------------------------------------'

nbAdresse = 200 # >= 3*nb de customer
nbOfUser = 50  # >= nbOfEmloyee + nbOfCustomer
nbOfEmployee = 20   
nbOfCustomer = 30


nbAdresse.times do
  Address.create([{
      address_type: [:Billing, :Shipping, :Home, :Business].sample,
      status: [:Active, :Inactive].sample,
      entity: [:Building, :Customer].sample,
      street_number_name: Faker::Address.secondary_address,
      apartment_number: Faker::Number.number(digits: 2),
      city: Faker::Address.city_prefix,
      zip_code: Faker::Address.postcode,
      country: Faker::Address.country,
      notes: Faker::Lorem.paragraph 
  }])

  end

  Geolocation.create!([
    { "name": "Buckingham Palace", "latitude": "51.501564","longitude": "-0.141944"},
    { "name": "Westminster Abbey", "latitude": "51.499581", "longitude": "-0.127309"},
    { "name": "Big Ben", "latitude": "51.500792", "longitude": "-0.124613"}
    ])


  nbOfUser.times do
     User.create([{
         email: Faker::Internet.safe_email,
         password: Faker::Internet.password,
         firstName: Faker::Name.first_name,
         lastName: Faker::Name.last_name,
         phoneNumber: Faker::PhoneNumber.cell_phone,
         companyName: Faker::Company.name
         
    }])
  end


i = 0

nbOfEmployee.times do
      Employee.create(
        [
          {
          email: Faker::Internet.safe_email,
          password: Faker::Internet.password,
          firstName: Faker::Name.first_name,
          lastName: Faker::Name.last_name,
          user_id: i +=1
     }
    ]
     )

    end


y = 0
q = nbOfCustomer


nbOfCustomer.times do

      customer = Customer.create(
        
          contact_email: Faker::Internet.safe_email,
          contact_full_name: Faker::FunnyName.name,
          contact_phone: Faker::PhoneNumber.cell_phone,
          business_name: Faker::Company.name,
          user_id: i +=1 ,
          address_id: y +=1
          )
    
        nbOfBuilding = rand(1..2)
          
        nbOfBuilding.times do

         building = Building.create(
    
        
          building_administrator_email: Faker::Internet.safe_email,
          building_administrator_full_name: Faker::Name.first_name,
          building_administrator_phone: Faker::PhoneNumber.cell_phone,
          building_technical_contact_name: Faker::Name.first_name,
          building_technical_contact_email: Faker::Internet.safe_email,
          building_technical_contact_phone: Faker::PhoneNumber.cell_phone,
          customer_id: customer.id,
          address_id: q +=1
    
          )

           1.times do
            
           BuildingDetail.create(
        
           building_id: building.id,
           information_key: Faker::Name.first_name,
           value: Faker::Lorem.paragraph
           )

          nbOfBattery = rand(1..2)
          selectEmploye = rand(1..nbOfEmployee)
                    
          nbOfBattery.times do

          battery = Battery.create(
            building_id: building.id,
            employee_id: selectEmploye = rand(1..nbOfEmployee),
            building_type: [:Residential, :Commercial, :Corporate, :Hybrid].sample,
            status: [:Active, :Inactive].sample,
            operations_certificate: Faker::Superhero.descriptor,
            information: Faker::Movies::Hobbit.character, 
            notes: Faker::Beer.brand,
            date_service_since: Faker::Date.backward(days: 1065),
            date_last_inspection: Faker::Date.backward(days: 1065)
    

          )

          nbOfColumn = rand(1..5)
          
          nbOfColumn.times do
          
          nbOfFloor = rand(1..50)

          column = Column.create(
            battery_id: battery.id,
            building_type: [:Residential, :Commercial, :Corporate, :Hybrid].sample,
            floors_served: nbOfFloor,
            status: [:Active, :Inactive].sample,
            information: Faker::Movies::Hobbit.character, 
            notes: Faker::Lorem.paragraph
  
          )

          nbOfElevator = rand(1..10)
        
          nbOfElevator.times do
        
          elveator = Elevator.create(

            column_id: column.id,
            serial_number: Faker::IDNumber.valid_south_african_id_number,
            model: [:Standard, :Premium, :Excelium].sample,
            building_type: [:Residential, :Commercial, :Corporate, :Hybrid].sample,
            status: [:Active, :Inactive, :Intervention].sample,
            information: Faker::Movies::Hobbit.character, 
            date_service_since: Faker::Date.backward(days: 1065),
            date_last_inspection: Faker::Date.backward(days: 1065),
            inspection_certificate: [:Yes, :No].sample,
            notes: Faker::Lorem.paragraph
          )


          end
     end
    end
    end

     end
  end




# i = 2
# y = 5


# 5.times do
#   Battery.create(
#     [{
#       building_type: [:Residential, :Commercial, :Corporate, :Hybrid].sample,
#       status: [:Active, :Inactive].sample,
#       date_service_since: Faker::Time.between(from: DateTime.now - 1095, to: DateTime.now)
#       building_administrator_phone: Faker::PhoneNumber.cell_phone,
#       building_technical_contact_name: Faker::Name.first_name.gsub(/\W/, '')
#       building_technical_contact_email: Faker::Internet.safe_email,
#       building_technical_contact_phone: Faker::PhoneNumber.cell_phone,
#       building_id: i,
#       employee_id: y
#  }]
#  )
#  i = i + 1    
#  y = y + 1
# end
     


#  5.times do
#     Customer.create([{
#         email: Faker::Internet.safe_email,
#         password: Faker::Internet.password,
#         firstName: Faker::Name.first_name.gsub(/\W/, '')
#         lastName: Faker::Name.last_name.gsub(/\W/, '')
#         phoneNumber: Faker::PhoneNumber.cell_phone,
#         companyName: Faker::Company.name
#     }])




#  3.times do
#     Employee.create([{
#         email: Faker::Internet.safe_email,
#         password: Faker::Internet.password,
#         firstName: Faker::Name.first_name.gsub(/\W/, '')
#         lastName: Faker::Name.last_name.gsub(/\W/, '')
#         phoneNumber: Faker::PhoneNumber.cell_phone,
#         companyName: Faker::Company.name
#     }])