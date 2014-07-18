class Installation < ActiveRecord::Base
  belongs_to :customer
  has_many :beacons, dependent: :destroy

  attr_accessible :name, :group, :customer_id, :created_at, :updated_at, :active  
end
