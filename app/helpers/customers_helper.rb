module CustomersHelper

  def customer_form_title(request)
    if request.path_info =~ /edit/
      "Edit Account"
    elsif request.path_info =~ /new/
      "New Company"
    end
  end

	def customer_since(customer)
		current_user.created_at.strftime("%B %Y")
	end

  def customer_category(customer)
    customer.category ? customer.category : "None"
  end

end
