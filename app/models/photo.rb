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

	has_attached_file :photo,
	  bucket: ENV['S3_BUCKET_NAME'],
	  s3_credentials: {
	    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
	    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
	  }, keep_old_files: true
end
