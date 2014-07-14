class AddFileToAudioClip < ActiveRecord::Migration
  def self.up
    add_attachment :audio_clips, :audio_file
  end

  def self.down
    remove_attachment :audio_clips, :audio_file
  end
end