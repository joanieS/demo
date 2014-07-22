# == Schema Information
#
# Table name: audio_clips
#
#  id         :integer          not null, primary key
#  caption    :string(255)
#  beacon_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  audio_file :binary
#

class AudioClip < ActiveRecord::Base
	belongs_to :beacon
end
