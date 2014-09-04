# == Schema Information
#
# Table name: installations
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  group       :string(255)
#  customer_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#  active      :boolean          default(FALSE)
#

class Installation < ActiveRecord::Base
  belongs_to :customer
  has_many :beacons, dependent: :destroy

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
end
