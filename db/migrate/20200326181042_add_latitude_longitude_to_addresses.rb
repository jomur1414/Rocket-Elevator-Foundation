class AddLatitudeLongitudeToAddresses < ActiveRecord::Migration[5.2]
  def up
    add_column :addresses, :latitude, :float
    add_column :addresses, :longitude, :float
  end
end
