class AddContentUrlToBeacons < ActiveRecord::Migration
  def change
    add_column :beacons, :content_url, :string
  end
end
