//= require jquery
//= require jquery_ujs
//= require underscore
//= require gmaps/google
//= require_tree .

$(document).ready(function() {

  // Reveal beacon content form fields based on content type selection.
  $("#beacon_content_type").change( function() {
    var $content = $("#beacon_content_type option:selected").val();
    $('.content-type-field').hide();

    if ( $content === "image" || $content === "local-video" ) {
      $('#content-file-field').show();
    } else if ( $content === "web" || $content === "web-video" ) {
      $('#content-url-field').show();
    }
  });
});
