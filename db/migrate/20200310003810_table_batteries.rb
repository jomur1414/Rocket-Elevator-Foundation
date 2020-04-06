class TableBatteries < ActiveRecord::Migration[5.2]
  def change


    create_table :batteries do |t|
      t.references :building, foreign_key: true
      t.references :employee, foreign_key: true

      t.string :building_type
      t.string :status
      t.date :date_service_since
      t.date :date_last_inspection
      t.string :operations_certificate
      t.text :information
      t.text :notes
    end
  end
end
