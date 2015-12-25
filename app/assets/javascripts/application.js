// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(document).ready(function() {

  $("#random").click(function(event) {
    event.preventDefault();
    $.get($("#random").attr("href"), function(data) {
      $("#random_question").html(data);	  
    }); 
    $.get(window.location.href + "/used_questions", function(data) {
      $("#used_questions").html(data);
    });	    
  });

  $("#reset_questions").click(function(event) {
   event.preventDefault();
   $.get($("#reset_questions").attr("href"), function() {});
   $.get(window.location.href + "/used_questions", function(data) {
     $("#used_questions").html(data);
   });	    
  });
});
