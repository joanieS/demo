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

  has_many :audio_clips
  accepts_nested_attributes_for :audio_clips, allow_destroy: true

  has_attached_file :content_image, default_url: "/assets/missing.png", 
    styles: {thumb: '100x100>', square: '200x200#', medium: '300x300>'}

  validates_attachment_content_type :content_image, :content_type => /.+\/.*\Z/

  validates_attachment_content_type :audio, :content_type => [ 'application/mp3', 'application/x-mp3', 'audio/mpeg', 'audio/mp3','audio/mpg' ],
                                    :message => 'file must be of filetype .mp3'

end
