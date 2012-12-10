// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


var tracking;
var lastRecentId = 0;


function showWindow() {
	$('#overlay').fadeIn(50);
	$('#window').fadeIn(300);
}

function hideWindow() {
	$('#overlay').fadeOut(50);
	$('#window').fadeOut(300);
}

function showPacket(id) {
	$.ajax({
	  url: "/main/packet_info?id=" + id,
	  context: document.body
	}).done(function(response) { 
	  $('#windowContent').html(response);
	  showWindow();
	});	
}

function track(name) {
	tracking = name;
	$.ajax({
	  url: "/main/track?name=" + name,
	  context: document.body
	}).done(function(response) { 
	  $('#trackingContent').html(response);
	  hideWindow();
	});	
}

function refresh() {
	$.ajax({
	  url: "/main/tracked?name=" + tracking,
	  context: document.body
	}).done(function(response) { 
	  $('#trackingContent').html(response);	  
	});		

	$.ajax({
	  url: "/main/recent?id=" + lastRecentId,
	  context: document.body
	}).done(function(response) { 
	  $('#recentContent .scrollList').prepend(response);	  
	  return(false);
	});		

	$.ajax({
	  url: "/main/nearby",
	  context: document.body
	}).done(function(response) { 
	  $('#nearbyContent').html(response);	  
	  return(false);
	});		

	return(false);

}


$(function() {
	$('#settingsButton').click(function() {
		showWindow();
	});

	$('#refreshButton').click(function() {
		refresh();
	});

	$('#closeButton').click(function() {
		hideWindow();
	});

	$('#overlay').click(function() {
		hideWindow();
	});

	// setInterval(refresh,2000);


});

