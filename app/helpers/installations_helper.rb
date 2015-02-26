module InstallationsHelper
  include ApplicationHelper

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
    set_s3

    set_aws_installation_id(beacon)
    @prefix = "beacons/content_images/000/000/" + "#{current_beacon_id}" + "/original"
    @default_prefix = "installations/images/000/000/" + "#{@aws_installation_id}" + "/original/"

    check_for_photos(@prefix)

    build_photo_gallery(@photo_gallery_images)
  end

  def set_aws_installation_id(beacon)
    @aws_installation_id = "%03d" % @installation.id
  end

  def check_for_photos(prefix)

    prefix_photos == [] ? @photo_gallery_images = default_prefix_photos : @photo_gallery_images = prefix_photos

    # @photo_gallery_images = @s3.buckets['lufthouse-dev'].objects.with_prefix(@prefix).collect(&:key)

    # if @photo_gallery_images == []
      
    #   @photo_gallery_images = @s3.buckets['lufthouse-dev'].objects.with_prefix(@default_prefix).collect(&:key)
    # end

  end

  def prefix_photos
    @s3.buckets['lufthouse-dev'].objects.with_prefix(@prefix).collect(&:key)
  end

  def default_prefix_photos
    @s3.buckets['lufthouse-dev'].objects.with_prefix(@default_prefix).collect(&:key)
  end

  def build_photo_gallery(photo_gallery_images)

    photo_gallery_images_URLs = Array.new

      photo_gallery_images.each do |f|
        photo_gallery_images_URLs << "https://s3.amazonaws.com/lufthouse-dev/" + f
      end

      return photo_gallery_images_URLs

  end

  def select_show(installation)
    
    @installation.beacons.each do |beacon|
      case beacon.content_type
      when "memories"
        beacon.content = get_audio_clips(beacon)
      when "photo-gallery"
        set_photo_gallery_content(beacon)
      when "image"
        beacon.content = beacon.content_image.url
      end

      set_audio_file_name(beacon)
    end
  end

  def set_photo_gallery_content(beacon)
    @current_beacon_id = "%03d" % beacon.id
    beacon.content = get_photo_gallery(@current_beacon_id, beacon)
  end

  def set_audio_file_name(beacon)
    if beacon.audio_file_name != nil && beacon.audio_file_name != "/audios/original/missing.png"
      beacon.audio_url = beacon.audio.url
    end
  end


  def get_audio_clips(beacon)
    set_s3

    find_record_beacon(@installation)

    prefix = "#{@customer.id}" + '/' + "#{@installation.id}" + '/' + "#{@record_beacon_id}"

    collect_audio_clips(prefix)
  end

  def collect_audio_clips(prefix)

    audio_clips = @s3.buckets['lufthouse-memories'].objects.with_prefix(prefix).collect(&:key)

    audio_clip_URLs = Array.new

    unless audio_clips == []
      audio_clips.each do |f|
        audio_clip_URLs << "https://s3.amazonaws.com/lufthouse-memories/" + f
      end
    end

    return audio_clip_URLs.shuffle
  end

  def find_record_beacon(installation)
    @record_beacon_id = Beacon.where(:installation_id => installation.id).where(:content_type => 'record-audio').first.id
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

  # def installations_path(customer)
  #   customer_installations_path(customer)
  # end

  def installation_path(installation)
    customer_installation_path(@customer, installation)
  end

  def installation_path(installation)
    customer_installation_path(@customer, installation)
  end

end
