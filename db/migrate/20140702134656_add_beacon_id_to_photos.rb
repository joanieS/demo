class AddBeaconIdToPhotos < ActiveRecord::Migration
  def change
  	add_column :photos, :beacon_id, :integer
  end
end
