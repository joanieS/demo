class AddImageToBeacons < ActiveRecord::Migration
  def self.up
    add_attachment :beacons, :content_image
  end

  def self.down
    remove_attachment :beacons, :content_image
  end
end
