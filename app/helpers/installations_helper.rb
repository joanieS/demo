module InstallationsHelper

  def installation_form_title(request)
    if request.path_info =~ /edit/
      "Edit Installation"
    elsif request.path_info =~ /new/
      "Add New Installation"
    end
  end

	def creation_date(installation)
		installation.created_at.strftime("%B %d, %Y")
	end

	def has_beacons?(installation)
		!installation.beacons.empty?
	end

  def display_content(beacon)
    beacon.content ? beacon.content : "No content description."
  end

end
