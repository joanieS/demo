module BeaconsHelper
  include ApplicationHelper

  def beacon_form_title(request)
    if request.path_info =~ /edit/
      "Edit Beacon"
    elsif request.path_info =~ /new/
      "Add New Beacon"
    end
  end

  def set_beacon_audio(beacon)
    beacon.audio_url = beacon.audio.url
    beacon.save!
  end


  def display_id(beacon_id)
    beacon_id ? beacon_id : "None."
  end

  def display_beacon_content_type(beacon_content_type)
    beacon_content_type ? beacon_content_type : "None."
  end

  def display_beacon_content(beacon)
    if beacon.content_type == "image" || beacon.content_type == "local-video"
      beacon.content_image_file_name ? beacon.content_image_file_name : "None."
    elsif beacon.content_type == "web" || beacon.content_type == "web-video"
      beacon.content_url ? beacon.content_url : "None."
    end
  end

  def display_audio(beacon_audio)
    beacon_audio ? beacon_audio : "None."
  end

  def set_customer_and_installation
    @customer = Customer.find(params[:customer_id])
    @installation = @customer.installations.find(params[:installation_id])
  end

  def set_beacon
    @beacon = @installation.beacons.find(params[:id])
  end

  def set_beacon_installation_id_and_uuid
    @beacon.installation_id = @installation.id
    @beacon.uuid = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
  end

  def set_beacon_lat_and_long
    @beacon.latitude = @customer.latitude
    @beacon.longitude = @customer.longitude
  end


  def beacon_params
    params.require(:beacon).permit(
      :minor_id, :major_id, :latitude, :longitude, :content, :content_type, 
      :audio, :content_image, :uuid, :active, :image_content, :location, :audio_url,
      :content_url, :description, photos: []
    )
  end

  # Paths

  def installation_path
    customer_installation_path(@customer, @installation)
  end

  def beacon_path
   customer_installation_beacon_path(@customer, @installation, @beacon)
  end

  def beacon_path(beacon)
    customer_installation_beacon_path(@customer, @installation, beacon)
  end

end
