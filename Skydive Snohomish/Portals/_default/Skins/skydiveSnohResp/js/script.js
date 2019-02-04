/*
 * jQuery hashchange event - v1.3 - 7/21/2010
 * http://benalman.com/projects/jquery-hashchange-plugin/
 * 
 * Copyright (c) 2010 "Cowboy" Ben Alman
 * Dual licensed under the MIT and GPL licenses.
 * http://benalman.com/about/license/
 */
(function($,e,b){var c="hashchange",h=document,f,g=$.event.special,i=h.documentMode,d="on"+c in e&&(i===b||i>7);function a(j){j=j||location.href;return"#"+j.replace(/^[^#]*#?(.*)$/,"$1")}$.fn[c]=function(j){return j?this.bind(c,j):this.trigger(c)};$.fn[c].delay=50;g[c]=$.extend(g[c],{setup:function(){if(d){return false}$(f.start)},teardown:function(){if(d){return false}$(f.stop)}});f=(function(){var j={},p,m=a(),k=function(q){return q},l=k,o=k;j.start=function(){p||n()};j.stop=function(){p&&clearTimeout(p);p=b};function n(){var r=a(),q=o(m);if(r!==m){l(m=r,q);$(e).trigger(c)}else{if(q!==m){location.href=location.href.replace(/#.*/,"")+q}}p=setTimeout(n,$.fn[c].delay)}$.browser.msie&&!d&&(function(){var q,r;j.start=function(){if(!q){r=$.fn[c].src;r=r&&r+a();q=$('<iframe tabindex="-1" title="empty"/>').hide().one("load",function(){r||l(a());n()}).attr("src",r||"javascript:0").insertAfter("body")[0].contentWindow;h.onpropertychange=function(){try{if(event.propertyName==="title"){q.document.title=h.title}}catch(s){}}}};j.stop=k;o=function(){return a(q.location.href)};l=function(v,s){var u=q.document,t=$.fn[c].domain;if(v!==s){u.title=h.title;u.open();t&&u.write('<script>document.domain="'+t+'"<\/script>');u.close();q.location.hash=v}}})();return j})()})(jQuery,this);

$(function(){
	
	$('a[href$=pdf]').attr('target','_blank');
	
	// Call the mask input plugin
	//$('.phone').mask('(999) 999-9999');
	//DD_roundies.addRule('.box', '3px');
	
    //for beloved IE
	if ($.browser.msie) {
	    $("html").addClass("ie");
	}

	// Banner slideshow
	if($('body').attr('id') == 'home') {
		var transition 	= 300;
		var pause 		= 4000;
		
		$('#banner').append($('#footer_images').html());
		setInterval(function(){
		  $('#banner :first-child').fadeOut(transition)
			 .next('img').fadeIn()
			 .end().appendTo('#banner');}, 
		  pause);
	}
	
	// background-size fallback - not required + fails with responsive dev
/*	if(!Modernizr.backgroundsize) {
		$('body').append(
			'<style>' + 
			'body { background-image:none !important; } ' +
			'#wrapper { position:relative; z-index:9999; }' +
			'img#bg {width:100%; height:100%; position:fixed; z-index:1; }' +
			'</style>'
		);
		$('body').append('<img src="/images/background.jpg" id="bg" />');
	}*/
	
	// input placeholder fallback
	if (!Modernizr.input.placeholder) {
		$('input[placeholder]').each(function() {
			$(this).val($(this).attr('placeholder'));
		});
		$('input[placeholder]').focus(function() {
			if($(this).val() == $(this).attr('placeholder')) {
				$(this).val('');
			}
		});
		$('input[placeholder]').blur(function() {
			if($(this).val() == '') {
				$(this).val($(this).attr('placeholder'));
			}
		});
		$('form').submit(function() {
			$('input[placeholder]').each(function() {
				if($(this).val() == $(this).attr('placeholder')) {
					$(this).val('');
				}
			});
		});
	}
	
	// hide loading image, on load
	$("#loading").hide();
	
	
	if($('#photo-video').length) {
		var hash 		= false;
		var thumbs 		= '';
		var vthumbs 	= '';
		var preloader	= '';
		var top 		= false;
		var next 		= false;
		
		if(location.hash.length) {
			hash = location.hash.substr(1);
		}
		
		$.getJSON('/ajax/flickr.php', function(flickr) {		
			$.each(flickr, function(key, val) {
				if(key == hash || (!hash && !top)) {
					next = val['next'];
					top = '<div class="flickr-image"><a href="#' + next + '"><img src="' + val['large'] + '"></a></div>';
					if(val['title'].length) {
						top += '<h2 class="caption">' + val['title'] + '</h2>';
					}
				}
				thumbs += '<a href="#' + key + '" class="grid_1 alpha">' +
				'<img src="' + val['thumbnail'] + '" title="' + val['title'] + '" width="100%"></a>';
				preloader += '<img src="' + val['large'] + '">';
			});
			$('.topbox').html(top);
			$('#photothumbnails').html(thumbs);
			
			// delay a second, then preload all large images
			$('body').delay(1000).append('<div id="preloader" class="hide">' + preloader + '</div>');

			// on hashchange, update topbox
			$(window).hashchange(function(){
				hash = location.hash.substr(1);
				if(flickr[hash] != undefined) {
					val = flickr[hash];
					next = val['next'];
					top = '<div class="flickr-image"><a href="#' + next + '"><img src="' + val['large'] + '"></a></div>';
					if(val['title'].length) {
						top += '<h2 class="caption">' + val['title'] + '</h2>';
					}
					$('.topbox').html(top);
				}
			});

			// 37 = left arrowkey, 39 = right arrowkey
			$(document).keyup(function(event) {
				if (event.keyCode == 39 && (!hash || !isNaN(hash))) {
					location.hash = '#' + next;
				}
			});
		});
		
		$.getJSON('/ajax/youtube.php', function(youtube) {	
			$.each(youtube, function(key, val) {
				if(key == hash) {
					top = '<iframe class="youtube-player" type="text/html" width="700" height="425" src="http://www.youtube.com/embed/' + key + '?autoplay=1&rel=0" frameborder="0"></iframe>';
				}
				vthumbs += '<a href="#' + key + '" class="grid_2 alpha"><img src="' + val['thumbnail'] + '" title="' + val['title'] + '" width="100%"></a>';
			});
			$('.topbox').html(top);
			$('#videothumbnails').html(vthumbs);

			// on hashchange, update topbox
			$(window).hashchange(function(){
				hash = location.hash.substr(1);
				if(youtube[hash] != undefined) {
					val = youtube[hash];
					top = '<iframe class="youtube-player" type="text/html" width="700" height="425" src="http://www.youtube.com/embed/' + hash + '?autoplay=1&rel=0" frameborder="0"></iframe>';
					$('.topbox').html(top);
				}
			});
		});
	}
	
});