module CustomersHelper

	def customer_since(customer)
		current_user.created_at.strftime("%B %Y")
	end

	def total_beacons(customer)
		customer.beacons.count
	end

end
