module InstallationsHelper

  def count_beacons(installation)
    installation.beacons.count
  end

  def installation_form_title(request)
    if request.path_info =~ /edit/
      "Edit Installation"
    elsif request.path_info =~ /new/
      "Add New Installation"
    end
  end

	def creation_date(installation)
		installation.created_at.strftime("%B %d, %Y")
	end

	def has_beacons?(installation)
		!installation.beacons.empty?
	end

  def display_content(beacon)
    beacon.content ? beacon.content : "No content description."
  end

  def get_photo_gallery(current_beacon_id, beacon)
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

  def select_show(installation)
    
    @installation.beacons.each do |beacon|

      if beacon.content_type == "memories"
        beacon.content = get_audio_clips(beacon)
      end

      if beacon.content_type == "photo-gallery"
        @current_beacon_id = "%03d" % beacon.id
        beacon.content = get_photo_gallery(@current_beacon_id, beacon)
      end

      if beacon.content_type == "image"
        beacon.content = beacon.content_image.url
      end

      if beacon.audio_file_name != nil && beacon.audio_file_name != "/audios/original/missing.png"
        beacon.audio_url = beacon.audio.url
      end
    end
  end

  def get_audio_clips(beacon)
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

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

  def set_installation
    @installation = @customer.installations.find(params[:id])
  end

  def set_customer_id
    @installation.customer_id = current_user.customer_id
  end

  def set_image_url
    if @installation.image_file_name != nil
      @installation.image_url = @installation.image.url
      @installation.save
    end
  end

  def installation_params
    params.require(:installation).permit(
      :name, :group, :customer_id, :active, :image_url, :image
      ) if params[:installation]
  end

  def set_installations
    @installations = Installation.where(:customer_id => @customer.id)
    @active_installations = Installation.where(:customer_id => @customer.id, :active => true)
  end

  # Paths
  def installations_path
    customer_installations_path(@customer)
  end

  def installation_path
    customer_installation_path(@customer, @installation)
  end

end
