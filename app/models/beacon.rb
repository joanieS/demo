class Beacon < ActiveRecord::Base
	belongs_to :installation
	has_many :photos
	accepts_nested_attributes_for :photos

	has_attached_file :content_image

  validates_attachment_content_type :content_image, :content_type => /.+\/.*\Z/

end

