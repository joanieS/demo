module BeaconsHelper

  def display_id(beacon_id)
    beacon_id ? beacon_id : "No ID."
  end

  def display_beacon_content_type(beacon_content_type)
    beacon_content_type ? beacon_content_type : "No content."
  end

  def display_beacon_content(beacon)
    if beacon.content_type == "image" || beacon.content_type == "local-video"
      beacon.content_file_name ? beacon.content_file_name : "No content."
    elsif beacon.content_type == "web" || beacon.content_type == "web-video"
      beacon.content_url ? beacon.content_url : "No content."
    end
  end

  def display_audio(beacon_audio)
    beacon_audio ? beacon_audio : "No audio file."
  end

end
