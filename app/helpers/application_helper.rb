module ApplicationHelper

	def total_installations(customer)
		customer.installations.count
	end

  def total_beacons(customer)
    customer.beacons.count
  end

  def current_state(object)
    object.active ? "Active" : "Inactive"    
  end

  # Coordinates

  def check_coordinates(object)
    !(object.latitude.nil? || object.longitude.nil?)
  end

  def cardinalized_latitude(object)
    object.latitude > 0 ? raw("#{object.latitude}&deg; N") : raw("#{object.latitude.abs}&deg; S")
  end

  def cardinalized_longitude(object)
    object.longitude > 0 ? raw("#{object.longitude}&deg; E") : raw("#{object.longitude.abs}&deg; W")
  end

  # Paths

    # Installation paths
    def installation_path(installation)
      customer_installation_path(@customer, installation)
    end

    def installations_path(customer)
      customer_installations_path(@customer)
    end

    def new_installation_path
      new_customer_installation_path(@customer)
    end

    def edit_installation_path(installation)
      edit_customer_installation_path(@customer, installation)
    end

    # Beacon paths
    def beacon_path(beacon)
      customer_installation_beacon_path(@customer, @installation, beacon)
    end

    def new_beacon_path
      new_customer_installation_beacon_path(@customer, @installation)
    end

    def edit_beacon_path(beacon)
      edit_customer_installation_beacon_path(@customer, @installation, beacon)
    end

    # Audio clip paths
    def audio_clip_path(audio_clip)
      customer_installation_beacon_path(@customer, @installation, @beacon, audio_clip)
    end
end
