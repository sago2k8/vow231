// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require materialize-sprockets
function evaluacion(param){
	if(param.hasClass('offset-l5')){
		param.removeClass('offset-l5').addClass('push-l3').removeClass('offset-m4');
	}
	else {
		param.addClass('offset-l5').removeClass('push-l3').addClass('offset-m4');
	}

}

$( document ).ready(function(){
	 $('registro-pushpin').pushpin({ top: $('#vow-description').offset().top });
	$(".button-collapse").sideNav();
	 $('.carousel').carousel();
	 $('.parallax').parallax();
	$('#registro').click(function(){
		evaluacion($(this));
		$('.button-vow-hide').toggle();
		$(".dropdown-button").dropdown();
		


	});
})

