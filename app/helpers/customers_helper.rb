module CustomersHelper

	def customer_since(customer)
		current_user.created_at.strftime("%B %Y")
	end

  def customer_category(customer)
    customer.category ? customer.category : "None"
  end

end
