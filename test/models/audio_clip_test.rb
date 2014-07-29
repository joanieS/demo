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

require 'test_helper'

class AudioClipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
