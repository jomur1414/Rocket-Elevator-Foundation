class ChangeDecimalToFloat < ActiveRecord::Migration[5.2]
  def up
    change_column :geolocations, :latitude, :float
    change_column :geolocations, :longitude, :float
  end

  def down
    change_column :geolocations, :latitude, :decimal
    change_column :geolocations, :longitude, :decimal
  end
end