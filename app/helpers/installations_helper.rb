module InstallationsHelper

	def creation_date(installation)
		installation.created_at.strftime("%B %d, %Y")
	end

	def has_beacons?(installation)
		!installation.beacons.empty?
	end

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
