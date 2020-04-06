class CreateGeolocations < ActiveRecord::Migration[5.2]
  def change
    create_table :geolocations do |t|
      t.string :name
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
