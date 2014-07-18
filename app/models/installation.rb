class Installation < ActiveRecord::Base
  belongs_to :customer
  has_many :beacons, dependent: :destroy

end
