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



$(document).ready(function() {

  $("#chose_links").on("click", "#random", function(event) {
    event.preventDefault();
    $.ajax({
      url: $("#random").attr("href"), 
      dataType: "json",
      success: function(data) {
         showQuestion(data); 
         updateUsedQuestion(data);
      }
    }); 
    return false;
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

function showQuestion(questionHash) {
  $("#random_question").html(questionHash == null ? "No more questions" : questionHash.random_question);
}

function updateUsedQuestion(questionHash) {
 $("#used_questions").empty();
 $(questionHash.used_questions).each(function(index, question) {
    var li = $('<li></li>').text(question.value);
    $("#used_questions").append(li);
 });
}
