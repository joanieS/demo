# == Schema Information
#
# Table name: beacons
#
#  id                         :integer          not null, primary key
#  minor_id                   :integer
#  content                    :text
#  content_type               :string(255)
#  audio                      :string(255)
#  installation_id            :integer
#  created_at                 :datetime
#  updated_at                 :datetime
#  content_image_file_name    :string(255)
#  content_image_content_type :string(255)
#  content_image_file_size    :integer
#  content_image_updated_at   :datetime
#  latitude                   :float
#  longitude                  :float
#  major_id                   :integer
#  uuid                       :string(255)
#  active                     :boolean          default(FALSE)
#

class Beacon < ActiveRecord::Base

	belongs_to :installation

  has_many :photos
  accepts_nested_attributes_for :photos, allow_destroy: true

  has_attached_file :content_image,
    styles: {thumb: '100x100>', square: '200x200#', medium: '300x300>'},
    default_url: "/assets/missing.png",
    bucket: ENV['S3_BUCKET_NAME'],
    s3_credentials: {
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    }

  validates_attachment_content_type :content_image, :content_type => /.+\/.*\Z/

  has_attached_file :audio
  
  validates_attachment_content_type :audio, :content_type => [ 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio' ]

end
