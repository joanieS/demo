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

  def content_image_array=(array)
    array.each do |file|
      content_images.build(:content_image => file)
    end
  end

  def self.get_audio_clips(beacon)
    s3 = AWS::S3.new(
      :access_key_id => Rails.application.secrets.AWS_ACCESS_KEY_ID,
      :secret_access_key => Rails.application.secrets.AWS_SECRET_ACCESS_KEY)

    record_beacon_id = Beacon.where(:installation_id => beacon.installation.id).where(:content_type => 'record-audio').first.id

    prefix = "#{beacon.installation.customer.id}" + '/' + "#{beacon.installation.id}" + '/' + "#{record_beacon_id}"

    audio_clips = s3.buckets['lufthouse-memories'].objects.with_prefix(prefix).collect(&:key)

    audio_clip_URLs = Array.new

    unless audio_clips == []
      audio_clips.each do |f|
        audio_clip_URLs << "https://s3.amazonaws.com/lufthouse-memories/" + f
      end
    end

    beacon.content = audio_clip_URLs.shuffle
  
  end


  def self.set_beacon_audio(beacon)
    beacon.audio_url = beacon.audio.url
    beacon.save!
  end
  #has_attached_file :content

end
