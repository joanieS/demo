json.cache! @customer do
	json.id @customer.id
	json.name @customer.name
	json.category @customer.category
	json.created_at @customer.created_at
	json.updated_at @customer.updated_at
	json.address @customer.address
	end
json.installations @active_installations
