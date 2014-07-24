class AddAudioToBeacons < ActiveRecord::Migration
  def self.up
    add_attachment :beacons, :audio
  end

  def self.down
    remove_attachment :beacons, :audio
  end
end
