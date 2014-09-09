$(document).ready(function() {

  // Animatiomns
	$('h1').addClass('animated bounceInDown');
  $('.form-control').bind('focus', function(){
    $(this).toggleClass('animated flipInX');
  });
	
	// Client images responsiveness
	$('.clientswrap img').addClass('img-responsive');
	
	// Smooth scrolling
	$('.smoothScroll').on('click', function (e) {
		e.preventDefault();

		var target = this.hash,
		$target = $(target);

		$('html, body').stop().animate({
			'scrollTop': $target.offset().top
		}, 800, 'swing', function () {
			window.location.hash = target;
		});
  });
	
	// Active links
	var sections = $("section"),
	navigation_links = $("#navigation a");
	
	sections.waypoint( {
		handler: function(event, direction) {
			var active_section;
			
			active_section = $(this);
			if (direction === "up") active_section = active_section.prev();

			var active_link = $('#navigation a[href="#' + active_section.attr("id") + '"]');

			navigation_links.parent().removeClass("active");
			active_link.parent().addClass("active");
		},
		offset: '35%'
	});

	// FitVids
	$(".fluid-video-wrapper").fitVids();

	// IE 10 in Windows 8 and Windows Phone 8 fix
	if (navigator.userAgent.match(/IEMobile\/10\.0/)) {
		var msViewportStyle = document.createElement('style')
		msViewportStyle.appendChild(
			document.createTextNode(
	    		'@-ms-viewport{width:auto!important}'
	    	)
		)
		document.querySelector('head').appendChild(msViewportStyle)
	}

	// Android stock browser fix
	var nua = navigator.userAgent
	var isAndroid = (nua.indexOf('Mozilla/5.0') > -1 && nua.indexOf('Android ') > -1 && nua.indexOf('AppleWebKit') > -1 && nua.indexOf('Chrome') === -1)
	if (isAndroid) {
		$('select.form-control').removeClass('form-control').css('width', '100%')
	}

});