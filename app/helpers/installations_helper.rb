module InstallationsHelper

	def has_beacons?(installation)
		!installation.beacons.empty?
	end

	def beacon_count(installation)
		installation.beacons.count
	end
end
