class ReplaceAudioClipAttachmentWithBlob < ActiveRecord::Migration
  def self.up
    remove_attachment :audio_clips, :audio_file
    add_column :audio_clips, :audio_file, :bytea
  end

  def self.down
    add_attachment :audio_clips, :audio_file
    remove_column :audio_clips, :audio_file, :bytea
  end
end
