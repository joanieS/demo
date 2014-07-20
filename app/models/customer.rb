class Customer < ActiveRecord::Base
  has_many :users, dependent: :destroy
  has_many :installations, dependent: :destroy
  has_many :beacons, through: :installations
end
