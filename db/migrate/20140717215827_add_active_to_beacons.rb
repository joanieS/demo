class AddActiveToBeacons < ActiveRecord::Migration
  def change
    add_column :beacons, :active, :boolean, :default => false
  end
end
