S3DirectUpload.config do |c|
  c.access_key_id     = Rails.application.secrets.AWS_ACCESS_KEY_ID
  c.secret_access_key = Rails.application.secrets.AWS_SECRET_ACCESS_KEY
  c.bucket            = Rails.application.secrets.S3_BUCKET_NAME
  c.region            = "s3"
  c.url = "https://#{c.bucket}.s3.amazonaws.com/"
end