class AddCoordinatesToBeacons < ActiveRecord::Migration
  def change
  	add_column :beacons, :latitude, :float
  	add_column :beacons, :longitude, :float
  end
end
