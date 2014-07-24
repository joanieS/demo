class AddLocationToBeacons < ActiveRecord::Migration
  def change
    add_column :beacons, :location, :text
  end
end
