module InstallationsHelper
	def has_beacons?(installation)
		!installation.beacons.empty?
	end
end
