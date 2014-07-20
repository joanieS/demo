class Customer < ActiveRecord::Base
  has_many :users
  has_many :installations, dependent: :destroy
  has_many :beacons, through: :installations
end
