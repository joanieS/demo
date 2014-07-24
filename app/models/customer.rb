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

class Customer < ActiveRecord::Base
  has_many :users, dependent: :destroy
  has_many :installations, dependent: :destroy
  has_many :beacons, through: :installations

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
end
