class CreateAudioClips < ActiveRecord::Migration
  def change
    create_table :audio_clips do |t|
      t.string :caption
      t.integer :beacon_id

      t.timestamps
    end
  end
end
