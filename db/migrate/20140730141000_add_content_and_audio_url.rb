class AddContentAndAudioUrl < ActiveRecord::Migration
  def change
    add_column :beacons, :content, :text
    add_column :beacons, :audio_url, :string
  end
end
