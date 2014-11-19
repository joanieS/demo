class AddBeaconToEvents < ActiveRecord::Migration
  def change
    add_column :events, :beacon_id, :integer
  end
end
