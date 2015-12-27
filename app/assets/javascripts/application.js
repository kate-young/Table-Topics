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
//= require bootstrap-sprockets

function showQuestion(questionHash) {
  $("#random_question").html(questionHash == null ? "No more questions" : questionHash.random_question);
}

function updateUsedQuestion(questionHash) {
 var htmlList = '';
 $(questionHash.used_questions).each(function(index, question) {
     htmlList += "<li>" + question.value + "</li>\n";
 });
 console.log(htmlList);
 $("#used_questions").html(htmlList);
}

$(document).ready(function() {

  $("#chose_links").on("click", "#random", function(event) {
    event.preventDefault();
    $.ajax({
      url: $("#random").attr("href"), 
      success: function(data) {
         showQuestion(data); 
         updateUsedQuestion(data);
	   }
    }); 
  });

  $(".footer").on("click", "#reset_questions", function(event) {
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
