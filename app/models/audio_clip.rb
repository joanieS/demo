class AudioClip < ActiveRecord::Base
	belongs_to :beacon

	def get_audio_clips
	    s3 = AWS::S3.new(
	    	:access_key_id => Rails.application.secrets.AWS_ACCESS_KEY_ID,
	    	:secret_access_key => Rails.application.secrets.AWS_SECRET_ACCESS_KEY)
	      
	    audio_clips = s3.buckets['lufthouse-memories']

	    audio_clips.objects['key'] #=> makes no request, returns an S3Object

	    audio_clips.objects.each do |f|
	    	URL_Array << "https://s3.amazonaws.com/lufthouse-memories/" + f.key
	    end
  	end
end
