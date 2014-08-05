module BeaconsHelper

  def display_id(beacon_id)
    beacon_id ? beacon_id : "No ID."
  end

  def display_content(beacon_content)
    beacon_content ? beacon_content : "No content."
  end

end
