class Installation < ActiveRecord::Base
  belongs_to :customer
  has_many :beacons, dependent: :destroy
  validates_presence_of :name

  has_attached_file :image,
    styles: { :medium => "300x300>", :thumb => "100x100>" },
    default_url: ActionController::Base.helpers.asset_path('logo_white.png'),
    bucket: ENV['S3_BUCKET_NAME'],
    s3_credentials: {
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    }

  validates_attachment_content_type :image, :content_type => [
    'image/png', 'image/jpeg', 'image/jpg', 'image/gif'
  ]

  def self.actives
    joins(:customer).where(installations: { :active => true }).uniq
  end

  def self.get_audio_clips(beacon)
    s3 = AWS::S3.new(
      :access_key_id => Rails.application.secrets.AWS_ACCESS_KEY_ID,
      :secret_access_key => Rails.application.secrets.AWS_SECRET_ACCESS_KEY)

    installation = Installation.find(beacon.installation_id)
    customer = Customer.find(installation.customer_id)

    record_beacon_id = Beacon.where(:installation_id => installation.id).where(:content_type => 'record-audio').first.id

    prefix = "#{customer.id}" + '/' + "#{installation.id}" + '/' + "#{record_beacon_id}"

    audio_clips = s3.buckets['lufthouse-memories'].objects.with_prefix(prefix).collect(&:key)

    audio_clip_URLs = Array.new

    unless audio_clips == []
      audio_clips.each do |f|
        audio_clip_URLs << "https://s3.amazonaws.com/lufthouse-memories/" + f
      end
    end

    return audio_clip_URLs.shuffle

  end

  def self.get_photo_gallery(current_beacon_id, beacon)
    s3 = AWS::S3.new(
      :access_key_id => Rails.application.secrets.AWS_ACCESS_KEY_ID,
      :secret_access_key => Rails.application.secrets.AWS_SECRET_ACCESS_KEY)

    installation = Installation.find(beacon.installation_id)

    aws_installation_id = "%03d" % installation.id
    prefix = "beacons/content_images/000/000/" + "#{current_beacon_id}" + "/original"
    default_prefix = "installations/images/000/000/" + "#{aws_installation_id}" + "/original/"

    photo_gallery_images = s3.buckets['lufthouseawsbucket'].objects.with_prefix(prefix).collect(&:key)

    if photo_gallery_images == []
      
      photo_gallery_images = s3.buckets['lufthouseawsbucket'].objects.with_prefix(default_prefix).collect(&:key)
    end
    
    photo_gallery_images_URLs = Array.new

      photo_gallery_images.each do |f|
        photo_gallery_images_URLs << "https://s3.amazonaws.com/lufthouseawsbucket/" + f
      end

      return photo_gallery_images_URLs

  end

  def self.select_show(installation)
    
    installation.beacons.each do |beacon|

      if beacon.content_type == "memories"
        beacon.content = Installation.get_audio_clips(beacon)
      end

      if beacon.content_type == "photo-gallery"
        @current_beacon_id = "%03d" % beacon.id
        beacon.content = Installation.get_photo_gallery(@current_beacon_id, beacon)
      end

      if beacon.content_type == "image"
        beacon.content = beacon.content_image.url
      end

      if beacon.audio_file_name != nil && beacon.audio_file_name != "/audios/original/missing.png"
        beacon.audio_url = beacon.audio.url
      end
    end
  end

end
