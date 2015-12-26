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

  $("#chose_links").on("click", "#random", function(event) {
    event.preventDefault();
    $.ajax({
      url: $("#random").attr("href"), 
      success: function(data) {
        $("#random_question").html(data.random_question == null ? "No more questions" : data.random_question);	  
	$("#used_questions").empty();
	$(data.used_questions).each(function(index, question) {
           $("#used_questions").append("<li>"+ question.value + "</li>");
	});
      }
    }); 
  });

  $("#chose_links").on("click", "#reset_questions", function(event) {
    event.preventDefault();
    $.ajax({
       url: $("#reset_questions").attr("href"),
       success: function() {
	 $("#random_question").empty();
	 $("#used_questions").empty();
       }
    });
  });

});
