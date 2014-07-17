module ApplicationHelper

	def total_installations(customer)
		customer.installations.count
	end

end
