class Beacon < ActiveRecord::Base
	belongs_to :installation
  has_many :photos
  accepts_nested_attributes_for :photos
  has_many :audio_clips
  accepts_nested_attributes_for :audio_clips
  has_attached_file :content_image
  validates_attachment_content_type :content_image, :content_type => /.+\/.*\Z/

  attr_accessible :minor_id, :major_id, :latitude, :longitude, :uuid, :active, :content, :content_type, :audio, :installation_id, :created_at, :updated_at, :content_image_file_name, :content_image_content_type, :content_image_file_name, :content_image_updated_at
end
