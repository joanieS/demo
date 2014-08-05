module BeaconsHelper

  def display_id(beacon_id)
    beacon_id ? beacon_id : "No ID."
  end

  def display_content(beacon_content)
    beacon_content ? beacon_content : "No content."
  end

  def display_audio(beacon_audio)
    beacon_audio ? beacon_audio : "No audio file."
  end

end
