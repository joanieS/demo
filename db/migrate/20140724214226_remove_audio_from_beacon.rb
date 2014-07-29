class RemoveAudioFromBeacon < ActiveRecord::Migration
  def change
    remove_column :beacons, :audio
  end
end
