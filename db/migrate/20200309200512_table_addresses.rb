class TableAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :address_type
      t.string :status
      t.string :entity
      t.string :street_number_name
      t.string :apartment_number
      t.string :city
      t.string :state_province
      t.string :zip_code
      t.string :country
      t.text :notes
      t.timestamps
    end
  end
end
