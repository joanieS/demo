class Beacon < ActiveRecord::Base
	belongs_to :installation
	has_many :photos
	accepts_nested_attributes_for :photos

	has_many :audio_clips
	accepts_nested_attributes_for :audio_clips

	has_attached_file :content_image

  validates_attachment_content_type :content_image, :content_type => /.+\/.*\Z/

end

