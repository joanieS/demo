class AddDescriptionToBeacons < ActiveRecord::Migration
  def change
    add_column :beacons, :description, :text
  end
end
