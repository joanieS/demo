# == Schema Information
#
# Table name: beacons
#
#  id                         :integer          not null, primary key
#  minor_id                   :integer
#  content                    :text
#  content_type               :string(255)
#  audio                      :string(255)
#  installation_id            :integer
#  created_at                 :datetime
#  updated_at                 :datetime
#  content_image_file_name    :string(255)
#  content_image_content_type :string(255)
#  content_image_file_size    :integer
#  content_image_updated_at   :datetime
#  latitude                   :float
#  longitude                  :float
#  major_id                   :integer
#  uuid                       :string(255)
#  active                     :boolean          default(FALSE)
#

require 'test_helper'

class BeaconTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
