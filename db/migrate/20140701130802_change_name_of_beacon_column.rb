class ChangeNameOfBeaconColumn < ActiveRecord::Migration
  def change
  	rename_column :beacons, :type, :content_type
  end
end
