module CustomersHelper

	def customer_since(customer)
		current_user.created_at.strftime("%B %Y")
	end

end
