
jQuery(window).ready(function() 
{
	$('.screen_right div .sideblock, .screen_right div .sideblock iframe').hover(function(){
	  $(this).addClass('hover');
	});

	$('.screen_right div .sideblock, .screen_right div .sideblock iframe').mouseleave(function(){
	  $(this).removeClass('hover');
	});
});
