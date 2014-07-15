module CustomersHelper
	# return customers's beacon count
	def beacon_count(customer)
		customer.beacons.count
	end

	# return customers's installation count
	def installation_count(customer)
		customer.installations.count
	end
end
