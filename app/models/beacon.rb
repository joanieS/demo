class Beacon < ActiveRecord::Base
	belongs_to :installation

  has_many :photos
  accepts_nested_attributes_for :photos, allow_destroy: true

  has_many :audio_clips
  accepts_nested_attributes_for :audio_clips, allow_destroy: true

  has_attached_file :content_image, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :content_image, :content_type => /.+\/.*\Z/
end
