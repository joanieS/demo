# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  url        :string(255)
#  caption    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  beacon_id  :integer
#

class Photo < ActiveRecord::Base
	belongs_to :beacon
end
