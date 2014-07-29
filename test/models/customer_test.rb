# == Schema Information
#
# Table name: customers
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  category        :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  activation_code :string(255)      default(""), not null
#  latitude        :float
#  longitude       :float
#

require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
