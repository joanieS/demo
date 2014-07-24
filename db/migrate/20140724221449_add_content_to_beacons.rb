class AddContentToBeacons < ActiveRecord::Migration
  def self.up
    add_attachment :beacons, :content
  end

  def self.down
    remove_attachment :beacons, :content
  end
end
