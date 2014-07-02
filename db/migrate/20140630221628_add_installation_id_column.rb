class AddInstallationIdColumn < ActiveRecord::Migration
  def change
  	add_column :beacons, :installation_id, :integer
  end
end
