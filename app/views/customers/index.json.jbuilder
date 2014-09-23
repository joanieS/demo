json.array!(@customers) do |customer|
	customer.installations.each do |installation|
		if installation.active == true 
			json.extract! customer, :id, :name, :category, :created_at, :updated_at, :installations
		end
	end
end