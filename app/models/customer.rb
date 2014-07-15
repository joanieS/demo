class Customer < ActiveRecord::Base
	has_many :users
	has_many :installations
	has_many :beacons, through: :installations
end
