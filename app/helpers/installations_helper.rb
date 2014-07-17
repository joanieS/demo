module InstallationsHelper
	
	def has_beacons?(installation)
		!installation.beacons.empty?
	end

	def total_beacons(installation)
		installation.beacons.count
	end
end
