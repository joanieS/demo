# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  url        :string(255)
#  caption    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  beacon_id  :integer
#

require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
