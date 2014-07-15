class Installation < ActiveRecord::Base
  belongs_to :user
  has_many :beacons
end
