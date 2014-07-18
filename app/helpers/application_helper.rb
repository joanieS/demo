module ApplicationHelper

	def total_installations(customer)
		customer.installations.count
	end

  def total_beacons(customer)
    customer.beacons.count
  end

  def current_state(object)
    object.active ? "active" : "inactive"    
  end

  # PATHS

    # Installation paths
    def installation_path(installation)
      customer_installation_path(@customer, installation)
    end

    def new_installation
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
end
