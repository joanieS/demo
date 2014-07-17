module InstallationsHelper

	def creation_date(installation)
		installation.created_at.strftime("%B %d, %Y")
	end

	def has_beacons?(installation)
		!installation.beacons.empty?
	end

	def beacon_count(installation)
		installation.beacons.count
	end
end
