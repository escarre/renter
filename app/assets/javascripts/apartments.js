// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$('#my_form_name').submit(function()
{
   if($('#code').val().length < 16)
   {
		 alert('Cannot submit, too short')
      return false;
   }
});