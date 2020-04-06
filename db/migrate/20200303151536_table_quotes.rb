class TableQuotes < ActiveRecord::Migration[5.2]
  def change

      create_table :quotes do |t|

      t.string :firstName
      t.integer :phoneNumber
      t.string :companyName
      t.string :email
      t.string :buildingType
      t.string :productGrade
      t.integer :nbAppartment
      t.integer :nbBusiness
      t.integer :nbFloor
      t.integer :nbBasement
      t.integer :nbCage
      t.integer :nbParking
      t.integer :nbOccupantFloor
      t.integer :nbOperatingHours
      t.integer :nbElevatorNeeded
      t.integer :instllationCost
      t.integer :totalCost
      t.timestamps
      
      end
  end
end

