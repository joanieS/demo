class Customer < ActiveRecord::Base
  has_many :users
  has_many :installations
  has_many :beacons, through: :installations

  attr_accessible :name, :category, :created_at, :updated_at
end