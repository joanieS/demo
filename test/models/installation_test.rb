# == Schema Information
#
# Table name: installations
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  group       :string(255)
#  customer_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#  active      :boolean          default(FALSE)
#

require 'test_helper'

class InstallationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
