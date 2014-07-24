class RemoveContentFromBeacon < ActiveRecord::Migration
  def change
    remove_column :beacons, :content
  end
end
