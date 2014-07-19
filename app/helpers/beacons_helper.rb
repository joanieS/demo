module BeaconsHelper

  def cardinalized_latitude(beacon)
    beacon.latitude > 0 ? raw("#{beacon.latitude}&deg; N") : raw("#{beacon.latitude.abs}&deg; S")
  end

  def cardinalized_longitude(beacon)
    beacon.longitude > 0 ? raw("#{beacon.longitude}&deg; E") : raw("#{beacon.longitude.abs}&deg; W")
  end
end