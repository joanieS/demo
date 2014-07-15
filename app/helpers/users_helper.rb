module UsersHelper
	# return current user's beacon count
	def beacon_count
		current_user.beacons.count
	end

	# return current user's installation count
	def installation_count
		current_user.installations.count
	end

end
