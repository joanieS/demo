//= require active_admin/base
//= require jquery

$(document).ready(function() {

	$("#beacon_content_input.string").hide()
	$("#beacon_content_input.file").hide()
	$(".photos").hide()

	$("#beacon_content_type_input").change(function() {
		var content_type = $('#beacon_content_type').val()

		if(content_type === "Photo Gallery") {
			$("#beacon_content_input.string").hide()
			$("#beacon_content_input.file").hide()
			$(".photos").show()
		}	
		else if(content_type === "Image") {
			$(".photos").hide()
			$("#beacon_content_input.string").hide()
			$("#beacon_content_input.file").show()
		}

		else {
			$("#beacon_content_input.string").show()
			$("#beacon_content_input.file").hide()
			$(".photos").hide()
		}

	});



//

});