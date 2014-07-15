class AddMajorIdToBeacons < ActiveRecord::Migration
  def change
  	add_column :beacons, :major_id, :integer
  end
end
