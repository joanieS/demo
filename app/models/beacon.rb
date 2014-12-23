# == Schema Information
#
# t.integer  "minor_id"
# t.string   "content_type"
# t.integer  "installation_id"
# t.datetime "created_at"
# t.datetime "updated_at"
# t.string   "content_image_file_name"
# t.string   "content_image_content_type"
# t.integer  "content_image_file_size"
# t.datetime "content_image_updated_at"
# t.float    "latitude"
# t.float    "longitude"
# t.integer  "major_id"
# t.string   "uuid"
# t.boolean  "active",                     default: false
# t.text     "location"
# t.string   "audio_file_name"
# t.string   "audio_content_type"
# t.integer  "audio_file_size"
# t.datetime "audio_updated_at"
# t.string   "content_file_name"
# t.string   "content_content_type"
# t.integer  "content_file_size"
# t.datetime "content_updated_at"
# t.text     "content"
# t.string   "audio_url"

class Beacon < ActiveRecord::Base

	belongs_to :installation

  has_many :photos
  accepts_nested_attributes_for :photos, allow_destroy: true

  has_attached_file :content_image,
    bucket: ENV['S3_BUCKET_NAME'],
    s3_credentials: {
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    }, keep_old_files: true

  validates_attachment_content_type :content_image, :content_type => [
    'video/mp4', 'image/png', 'image/jpeg', 'image/jpg', 'image/gif'
  ]

  has_attached_file :audio,
  bucket: ENV['S3_BUCKET_NAME'],
    s3_credentials: {
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    }
    
  validates_attachment_content_type :audio, :content_type => [ 
    'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 
    'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio', 'audio/wav'
  ]

  def content_images=(files = [])
    files.each{|f| (@content_images ||= []) << photos.create(content_image: f) }
  end

  #has_attached_file :content

end
