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

class Installation < ActiveRecord::Base
  belongs_to :customer
  has_many :beacons, dependent: :destroy

end
