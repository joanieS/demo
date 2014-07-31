json.array!(@customers) do |customer|
	json.extract! customer, :id, :name, :category, :created_at, :updated_at, :installations
end