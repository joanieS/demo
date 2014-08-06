module BeaconsHelper

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

end
