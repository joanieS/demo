class DropBeaconTable < ActiveRecord::Migration
	def up
    drop_table :beacons
  end

  def down
    create_table :beacons do |t|
      t.string :name
      t.timestamps        
    end
  end
end
