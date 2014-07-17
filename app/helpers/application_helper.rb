module ApplicationHelper

	def total_installations(customer)
		customer.installations.count
	end

  def current_state(object)
    object.active ? "Active" : "Inactive"    
  end

end
