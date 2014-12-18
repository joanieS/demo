json.array!(@customers) do |customer|
	if customer.installations.actives.count > 0
		json.extract! customer, :id, :name, :category, :created_at, :updated_at
		json.installations customer.installations.actives
	end
end