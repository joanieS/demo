module CustomersHelper
	# return customers's beacon count
	def beacon_count
		self.beacons.count
	end

	# return customers's installation count
	def installation_count
		self.installations.count
	end
end
