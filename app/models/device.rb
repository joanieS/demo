class Device < ActiveRecord::Base
	has_many :events
	has_many :beacons, :through => :events
end
