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


end
