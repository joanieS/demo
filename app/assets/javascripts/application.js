//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require underscore
//= require bootstrap
//= require gmaps/google
//= require_tree .

$(document).ready(function() {

  var AddButton = $(".add-more-fields");
  var InputsWrapper = $("#InputsWrapper");

  var x = InputsWrapper.length;
  var FieldCount = 1;

  var createBeacon = $("#createBeacon");

  // var photoGalleryContent = $.map( '[id^="photo_"]', function ( e ) { 
  //   return $(this).val() ; 
  //   });

  // Reveal beacon content form fields based on content type selection.

  $('#content-url-field, #content-file-field, #audio-field').show();
  $('#content-file-field-multiple').hide();

  $("#beacon_content_type").change( function() {
    var $content = $("#beacon_content_type option:selected").val();
    $('.content-type-field, #content-file-field-multiple').hide();

    if ( $content === "image") {
      $('#content-url-field, #content-file-field, #audio-field').show();
      $('#content-file-field-multiple').hide();
    } else if ( $content === "local-video" ) {
      $('#content-file-field').show();
      $('#audio-field').hide();
    } else if ( $content === "web-video" ) {
      $('#content-url-field').show();
      $('#content-file-field, #audio-field').hide();
    }
      else if ( $content === "web" ) {
      $('#content-url-field, #audio-field').show();
      $('#content-file-field').hide();
    } else if ( $content === "photo-gallery" ) {
      $('#content-file-field-multiple, #audio-field').show();
    } else if ( $content === "photobooth" || $content === "memories" || $content === "record-audio" ) {
      $('#audio-field').hide();
    }
  });

  // $(AddButton).click(function (e)
  // {
  //   e.preventDefault();
  //   console.log(FieldCount);
    
  //   $(InputsWrapper).append('<div><input type="text" name="mytext[]" class="photo-gallery" id="photo_'+ FieldCount +'"/><a href="#" class="removeclass">&times;</a><a href="#" class="addclass"> + </a></div>');
  //   FieldCount++;
  //   x++;

  // });

  $("body").on("click",".removeclass", function(e) {
    if( x > 1 ) {
      $(this).parent('div').remove();
      x--;
    }
    return false;
  });

  // This function adds styling when a nav btn is clicked.
  $('.nav-btn').on('click', function() {
    $(this).addClass('nav-btn-clicked');
  });

  $('input[type="submit"]').on('click', function(){
    $(this).attr('id', 'submit-clicked');
  });

  $('.button').on('click', function() {
    $(this).addClass('button-clicked');
  });

  // Hides form label if field is empty

  $("body").on("click",".addclass", function(e) {
    $(InputsWrapper).append('<div><input type="text" name="mytext[]" id="field_'+ FieldCount +'"/><a href="#" class="removeclass">&times;</a><a href="#" class="addclass"> + </a></div>');
    FieldCount++;
    x++;
    return false;
  });

  // $(createBeacon).on("click", function(e) {
  //   e.preventDefault();
  //   console.log(photoGalleryContent);
  // });

});
