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

end
