function getURLVar(key) {
    var value = [];
    
    var query = String(document.location).split('?');
    
    if (query[1]) {
        var part = query[1].split('&');

        for (i = 0; i < part.length; i++) {
            var data = part[i].split('=');
            
            if (data[0] && data[1]) {
                value[data[0]] = data[1];
            }
        }
        
        if (value[key]) {
            return value[key];
        } else {
            return '';
        }
    }
} 

function addToCart(product_id, quantity) {
    quantity = typeof(quantity) != 'undefined' ? quantity : 1;

    $.ajax({
	    url: 'index.php?route=checkout/cart/add',
	    type: 'post',
	    data: 'product_id=' + product_id + '&quantity=' + quantity,
	    dataType: 'json',
	    success: function(json) {
		    $('.success, .warning, .attention, .information, .error').remove();
		    
		    if (json['redirect']) {
			    location = json['redirect'];
		    }
		    
		    if (json['success']) {
			    $('#notification').html('<div class="information" style="display: none;"><a class="close" href="#close"></a> ' + json['success'] + '</div>');
			    
			    $('.information').fadeIn('slow');
			    
                if (opencart_version >= 2000) 
                {
					$('.cart').load('index.php?route=common/cart/info  .cart > *', function () {$(".cart .cart-info").css("visibility", "visible");});
                } else 
                {
					$('.cart').load('index.php?route=module/cart .cart > *', function () {$(".cart .cart-info").css("visibility", "visible");});
                }
				timeout = setTimeout(function() {$('.information').fadeOut('slow');}, 7000);                
				$('.information').mouseenter(function()
				{
					clearTimeout(timeout);
					timeout = setTimeout(function() {$('.information').fadeOut('slow');}, 7000);                
				})		    
		    }	
	    }
    });
    
    return false;
}

		
$(document).ready(function () 
{
	$('.selectpicker').selectpicker({});

	$('select[name="profile_id"], input[name="quantity"]').change(function(){
		$.ajax({
			url: 'index.php?route=product/product/getRecurringDescription',
			type: 'post',
			data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'profile_id\']'),
			dataType: 'json',
			beforeSend: function() {
				$('#profile-description').html('');
			},
			success: function(json) {
				$('.alert, .text-danger').remove();
			
				if (json['success']) {
					$('#profile-description').html(json['success']);
				}
			}
		});
	});

	$(document).delegate('.button-cart','click', function() {
//		console.log(jQuery(this).parents("#product"));
		_product = jQuery(this).parents("#product").parent();
		//console.log($('#product input[type=\'text\'], #product input[type=\'date\'], #product input[type=\'datetime-local\'], #product input[type=\'time\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea', _product));
		$.ajax({
			url: 'index.php?route=checkout/cart/add',
			type: 'post',
			data: $('#product input[type=\'text\'], #product input[type=\'date\'], #product input[type=\'datetime-local\'], #product input[type=\'time\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea', _product),
			dataType: 'json',
			beforeSend: function() {
				$('.button-cart').button('loading');
			},      
			complete: function() {
				$('.button-cart').button('reset');
			},		
			success: function(json) {
				$('.alert, .text-danger').remove();
				
				if (json['error']) {
					if (json['error']['option']) {
						for (i in json['error']['option']) {
							$('#input-option' + i).after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						}
					}

					if (json['error']['profile']) {
						$('select[name=\'profile_id\']').after('<div class="text-danger">' + json['error']['profile'] + '</div>');
					}
				} 
				
				if (json['success']) {
					//$('.breadcrumb').after('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
					$('#notification').html('<div class="information" style="display: none;"><a class="close" href="#close"></a>' + json['success'] + '</div>');
					$('.information').fadeIn('slow');
						
					$('#cart-total').html(json['total']);
					
					if (opencart_version >= 2000) 
					{
						$('.cart').load('index.php?route=common/cart/info  .cart > *', function () {$(".cart .cart-info").css("visibility", "visible");});
					} else {
						$('.cart').load('index.php?route=module/cart .cart > *', function () {$(".cart .cart-info").css("visibility", "visible");});
					} 

					timeout = setTimeout(function() {$('.information').fadeOut('slow');}, 7000);                
					$('.information').mouseenter(function()
					{
						clearTimeout(timeout);
						timeout = setTimeout(function() {$('.information').fadeOut('slow');}, 7000);                
					})
					
					//check if not popup
					if (jQuery("#cboxLoadedContent .container").length = 0)
					$('html, body').animate({ scrollTop: 0 }, 'slow');
				}   
			}
		});
	});

	$(document).delegate('.buynow','click', function() {
//		console.log(jQuery(this).parents("#product"));
		_product = jQuery(this).parents("#product").parent();
		_checkout = jQuery(this).attr("data-checkout");
		//console.log($('#product input[type=\'text\'], #product input[type=\'date\'], #product input[type=\'datetime-local\'], #product input[type=\'time\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea', _product));
		$.ajax({
			url: 'index.php?route=checkout/cart/add',
			type: 'post',
			data: $('#product input[type=\'text\'], #product input[type=\'date\'], #product input[type=\'datetime-local\'], #product input[type=\'time\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea', _product),
			dataType: 'json',
			beforeSend: function() {
				$('.buynow').button('loading');
			},      
			complete: function() {
				$('.buynow').button('reset');
			},		
			success: function(json) {
				$('.alert, .text-danger').remove();
				
				if (json['error']) {
					if (json['error']['option']) {
						for (i in json['error']['option']) {
							$('#input-option' + i).after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						}
					}

					if (json['error']['profile']) {
						$('select[name=\'profile_id\']').after('<div class="text-danger">' + json['error']['profile'] + '</div>');
					}
				} 
				
				if (json['success']) {
					
					window.location = 'index.php?route=checkout/' + _checkout;//<?php if (nico_get_config('checkout')  == '1') echo 'nicocheckout'; else echo 'checkout'; ?>';
					
					//$('.breadcrumb').after('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
					$('#notification').html('<div class="information" style="display: none;">' + json['success'] + '</div>');
					$('.information').fadeIn('slow');
						
					$('#cart-total').html(json['total']);
					
					if (opencart_version >= 2000) 
					{
						$('.cart').load('index.php?route=common/cart/info  .cart > *', function () {$(".cart .cart-info").css("visibility", "visible");});
					} else {
						$('.cart').load('index.php?route=module/cart .cart > *', function () {$(".cart .cart-info").css("visibility", "visible");});
					} 

					timeout = setTimeout(function() {$('.information').fadeOut('slow');}, 7000);                
					$('.information').mouseenter(function()
					{
						clearTimeout(timeout);
						timeout = setTimeout(function() {$('.information').fadeOut('slow');}, 7000);                
					})
					
					//check if not popup
					if (jQuery("#cboxLoadedContent .container").length = 0)
					$('html, body').animate({ scrollTop: 0 }, 'slow');
				}   
			}
		});
		
		return false;
	});

	$(document).delegate('button[id^=\'button-upload\']','click', function() {
	//$('button[id^=\'button-upload\']').on('click', function() {
		var node = this;
		
		$('#form-upload').remove();
		
		$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

		$('#form-upload input[name=\'file\']').trigger('click');


		if (opencart_version < 2000) 
		{
			url = 'index.php?route=product/product/upload';
		} else 
		{
			url = 'index.php?route=tool/upload';
		}
		
		$('#form-upload input[name=\'file\']').on('change', function() {
			$.ajax({
				url: url,
				type: 'post',		
				dataType: 'json',
				name: 'file',
				data: new FormData($(this).parent()[0]),
				cache: false,
				contentType: false,
				processData: false,		
				beforeSend: function() {
					$(node).find('i').replaceWith('<i class="fa fa-spinner fa-spin"></i>');
					$(node).prop('disabled', true);
				},
				complete: function() {
					$(node).find('i').replaceWith('<i class="fa fa-upload"></i>');
					$(node).prop('disabled', false);			
				},		
				success: function(json) {
					if (json['error']) {
						$(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
					}
								
					if (json['success']) {
						alert(json['success']);
						
						if (typeof json['code'] != 'undefined')
						$(node).parent().find('input').attr('value', json['code']);
						
						if (typeof json['file'] != 'undefined')
						$(node).parent().find('input').attr('value', json['file']);
					}
				},			
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		});
	});

	$('#review').delegate('.pagination a, .links a', 'click', function(e) {
		e.preventDefault();
		
		$('#review').fadeOut('slow');
			
		$('#review').load(this.href);
		
		$('#review').fadeIn('slow');
	});         

	$('#review').load('index.php?route=product/product/review&product_id=' + jQuery('input[name=\'product_id\']').val());

	$(document).delegate('#button-review', 'click', function() {
		
		if (opencart_version >= 2000) { src= 'index.php?route=tool/captcha';} else {src= 'index.php?route=product/product/captcha';}
		
		$.ajax({
			url: 'index.php?route=product/product/write&product_id=' + jQuery("input[name=product_id]").val(),
			type: 'post',
			dataType: 'json',
			data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
			beforeSend: function() {
				$('#button-review').button('loading');
			},
			complete: function() {
				$('#button-review').button('reset');
				$('#captcha').attr('src', src + '#'+new Date().getTime());
				$('input[name=\'captcha\']').val('');
			},
			success: function(json) {
				$('.alert-success, .alert-danger').remove();
				
				if (json['error']) {
					$('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
				}
				
				if (json['success']) {
					$('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
									
					$('input[name=\'name\']').val('');
					$('textarea[name=\'text\']').val('');
					$('input[name=\'rating\']:checked').prop('checked', false);
					$('input[name=\'captcha\']').val('');
				}
			}
		});
	});
	
	  // Cart Dropdown
	  /*
	$(document).on('click', '#cart.dropdown-toggle', function() {
	    $('#cart').load('/index.php?route=module/cart .cart > *');
	});*/
	

	var cart_hover = true;
	$(document).on("mouseenter", "#cart.dropdown-toggle",function(e)
	{

		if (cart_hover)
		{
			//$(".cart .cart-info").css("visibility", "visible");
			if (opencart_version >= 2000) 
			{
				$('.cart').load('index.php?route=common/cart/info  .cart > *', function () {$(".cart .cart-info").css("visibility", "visible");});
			} else 
			{
				$('.cart').load('index.php?route=module/cart .cart > *', function () {$(".cart .cart-info").css("visibility", "visible");});
			}
		}
		
		cart_hover = false;
		setTimeout(function () {cart_hover= true}, 1000);
		
		e.preventDefault();		
	});


	 $(".header .navbar input.search-query").searchautocomplete("/index.php?route=product/search&ajax&filter_name=");
	 
	 
	/* Search */
	$('.navbar-search button.icon-search').on('click', function(e) {
		url = $('base').prop('href') + 'index.php?route=product/search';
				 
		var search = $('.navbar-search input.search-query').prop('value');
		var category_id = $('.navbar-search select[name=category_id]').prop('value');

		if (search) {
			url += '&search=' + encodeURIComponent(search);
			if (category_id) url +=  '&category_id=' + category_id;
		} else
		{
			var filter_name = $('input[name=\'filter_name\']').prop('value');
		
			if (filter_name) {
				url += '&filter_name=' + encodeURIComponent(filter_name);
				if (category_id) url +=  + '&category_id=' + category_id;;
			}
		}
		
		window.location = url;
		e.preventDefault();
		return false;
	});
	
	$('.navbar-form input.search-query').on('keydown', function(e) {
		if (e.keyCode == 13) {
			url = $('base').prop('href') + 'index.php?route=product/search';
			 
			var search = $('.navbar-search input.search-query').prop('value');
			
			if (search) {
				url += '&search=' + encodeURIComponent(search);
				if (category_id) url =  + '&category_id=' + category_id;;
			}
			
			window.location = url;
		}
	}).click(function (e) 
	{
		this.value = '';
	});


	$(".navbar-form input.search-query").searchautocomplete($('base').attr('href')  + "index.php?route=product/search&ajax&filter_name=");

	
	$('#header input[name=\'filter_name\']').on('keydown', function(e) {
		this.style.color = '#000000';
		if (e.keyCode == 13) {
			url = $('base').prop('href') + 'index.php?route=product/search';
			 
			var filter_name = $('input[name=\'filter_name\']').prop('value');
			
			if (filter_name) {
				url += '&filter_name=' + encodeURIComponent(filter_name);
			}
			
			window.location = url;
		}
	}).click(function (e) 
	{
		this.value = '';
	});
	
	// Product List
	$('#list-view').click(function() {
		
		$('#content .product-layout > div').addClass('product-list');
		$('#content .product-layout > div > div').attr('class','col-md-12 prod');

		var $image = $('#content .product-layout > div .product > div.image');
		
		//if ($image.hasClass('hover_img')) $image.attr('class', 'image hover_img ' + _nico_category_cols);
		//else 
		$image.attr('class', 'image ' + _nico_category_cols);
  	    jQuery(".image:has(.additional_image)").addClass("hover_img");
		
		$('#content .product-layout > div .product > div.actions').attr('class', 'actions col-md-7');
		
		localStorage.setItem('display', 'list');
		 $('#list-view').addClass("selected");
		 $('#grid-view').removeClass("selected");
	});

	// Product Grid
	$('#grid-view').click(function() {
			
		 $('#content .product-layout > div').removeClass('product-list');

		 $('#content .product-layout > div > div').attr('class', 'prod ' + _nico_category_cols);

		 var $image = $('#content .product-layout > div .product > div.image');

		 //if ($image.hasClass('hover_img')) $image.attr('class', 'image hover_img');
		 //else 
		 $image.attr('class', 'image');
		 jQuery(".image:has(.additional_image)").addClass("hover_img");

		 $('#content .product-layout > div .product > div.actions').attr('class', 'actions');
		
		 localStorage.setItem('display', 'grid');
		 $('#list-view').removeClass("selected");
		 $('#grid-view').addClass("selected");
	});

	if (localStorage.getItem('display') == 'list') {
		$('#list-view').trigger('click');
	} else {
		$('#grid-view').trigger('click');
	}
	
	jQuery("span.quickview").click(function (event) 
	{
		$.colorbox({iframe:false,width:800,height:700,maxWidth:'95%', maxHeight:'95%',href:this.parentNode.href + "&ajax=true"});
		event.stopPropagation();
		event.stopImmediatePropagation();
		event.preventDefault();
		return false;
	});

	$('#notification').delegate('a.close, .success a.close, .warning a.close, .attention a.close, .information a.close .success img, .warning img, .attention img, .information img','click', function(e) {
		$(this).parent().fadeOut('slow', function() {
			$(this).remove();
		});
		e.preventDefault();
		return false;
	});	
});





// Cart add remove functions	
var cart = {
	'add': function(product_id, quantity) {
		$.ajax({
			url: 'index.php?route=checkout/cart/add',
			type: 'post',
			data: 'product_id=' + product_id + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
			dataType: 'json',
			beforeSend: function() {
				$('#cart > button').button('loading');
			},      
			success: function(json) {
				$('.alert, .text-danger').remove();
				
				$('#cart > button').button('reset');
				
				if (json['redirect']) {
					location = json['redirect'];
				}
				
				if (json['success']) {
					$('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
					
					$('#cart-total').html(json['total']);
					
					//check if not popup
					if (jQuery("#cboxLoadedContent .container").length = 0)
					$('html, body').animate({ scrollTop: 0 }, 'slow');

					if (opencart_version >= 2000) 
					{
						$('.cart').load('index.php?route=common/cart/info  .cart > *', function () {$(".cart .cart-info").css("visibility", "visible");});
					} else 
					{
						$('.cart').load('index.php?route=module/cart .cart > *', function () {$(".cart .cart-info").css("visibility", "visible");});
					}
				}
			}
		});
	},
	'update': function(key, quantity) {
		if (opencart_version >= 2000) 
		{
			cart_action = 'edit';
		} else 
		{
			cart_action = 'update';
		}
		$.ajax({
			url: 'index.php?route=checkout/cart/' + cart_action,
			type: 'post',
			data: 'key=' + key + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
			dataType: 'json',
			beforeSend: function() {
				$('#cart > button').button('loading');
			},      
			success: function(json) {
				$('#cart > button').button('reset');
				
				$('#cart-total').html(json['total']);
				
				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = 'index.php?route=checkout/cart';
				} else {
					if (opencart_version >= 2000) 
					{
						$('.cart').load('index.php?route=common/cart/info  .cart > *', function () {$(".cart .cart-info").css("visibility", "visible");});
					} else 
					{
						$('.cart').load('index.php?route=module/cart .cart > *', function () {$(".cart .cart-info").css("visibility", "visible");});
					}
				}			
			}
		});			
	},
	'remove': function(key) {
		$.ajax({
			url: 'index.php?route=checkout/cart/remove',
			type: 'post',
			data: 'key=' + key,
			dataType: 'json',
			beforeSend: function() {
				$('#cart > button').button('loading');
			},      			
			success: function(json) {
				$('#cart > button').button('reset');
				
				$('#cart-total').html(json['total']);
				
				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = 'index.php?route=checkout/cart';
				} else {
					if (opencart_version >= 2000) 
					{
						$('.cart').load('index.php?route=common/cart/info  .cart > *', function () {$(".cart .cart-info").css("visibility", "visible");});
					} else 
					{
						$('.cart').load('index.php?route=module/cart .cart > *', function () {$(".cart .cart-info").css("visibility", "visible");});
					}
				}
			}
		});			
	}
}

var voucher = {
	'add': function() {
		
	},
	'remove': function(key) {
		if (opencart_version >= 2000) 
		{
			cart_action = 'checkout/cart/remove';
		} else 
		{
			cart_action = 'account/voucher/remove';
		}

		$.ajax({
			url: 'index.php?route=' + cart_action ,
			type: 'post',
			data: 'key=' + key,
			dataType: 'json',
			beforeSend: function() {
				$('#cart > button').button('loading');
			},      
			complete: function() {
				$('#cart > button').button('reset');
			},			
			success: function(json) {
				$('#cart-total').html(json['total']);
				
				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = 'index.php?route=checkout/cart';
				} else {
					if (opencart_version >= 2000) 
					{
						$('.cart').load('index.php?route=common/cart/info  .cart > *', function () {$(".cart .cart-info").css("visibility", "visible");});
					} else 
					{
						$('.cart').load('index.php?route=module/cart .cart > *', function () {$(".cart .cart-info").css("visibility", "visible");});
					}
				}			
			}
		});	
	}
}

var wishlist = {
	'add': function(product_id) {
		$.ajax({
			url: 'index.php?route=account/wishlist/add',
			type: 'post',
			data: 'product_id=' + product_id,
			dataType: 'json',
			success: function(json) {
				$('.alert').remove();
							
				if (json['success']) {
					$('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}

				if (json['info']) {
					$('#content').parent().before('<div class="alert alert-info"><i class="fa fa-info-circle"></i> ' + json['info'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}
					
				$('#wishlist-total').html(json['total']);
				
				//check if not popup
				if (jQuery("#cboxLoadedContent .container").length = 0)
				$('html, body').animate({ scrollTop: 0 }, 'slow');
			}   
		});
	},
	'remove': function() {
	
	}
}

var compare = {
	'add': function(product_id) {
		$.ajax({
			url: 'index.php?route=product/compare/add',
			type: 'post',
			data: 'product_id=' + product_id,
			dataType: 'json',
			success: function(json) {
				$('.alert').remove();
							
				if (json['success']) {
					$('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
					
					$('#compare-total').html(json['total']);
					
					//check if not popup
					if (jQuery("#cboxLoadedContent .container").length = 0)
					$('html, body').animate({ scrollTop: 0 }, 'slow');
				}   
			}
		});
	},
	'remove': function() {
	
	}
}

/* Agree to Terms */
$(document).delegate('.agree, .colorbox', 'click', function(e) {
	e.preventDefault();

	$('#modal-agree').remove();

	var element = this;

	$.ajax({
		url: $(element).attr('href'),
		type: 'get',
		dataType: 'html',
		success: function(data) {
			html  = '<div id="modal-agree" class="modal">';
			html += '  <div class="modal-dialog">';
			html += '    <div class="modal-content">';
			html += '      <div class="modal-header">';
			html += '        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>';
			html += '        <h4 class="modal-title">' + $(element).text() + '</h4>';
			html += '      </div>';
			html += '      <div class="modal-body">' + data + '</div>';
			html += '    </div';
			html += '  </div>';
			html += '</div>';

			$('body').append(html);

			$('#modal-agree').modal('show');
		}
	});
});

// Autocomplete */
(function($) {
	$.fn.autocomplete = function(option) {
		return this.each(function() {
			this.timer = null;
			this.items = new Array();

			$.extend(this, option);

			$(this).attr('autocomplete', 'off');

			// Focus
			$(this).on('focus', function() {
				this.request();
			});

			// Blur
			$(this).on('blur', function() {
				setTimeout(function(object) {
					object.hide();
				}, 200, this);
			});

			// Keydown
			$(this).on('keydown', function(event) {
				switch(event.keyCode) {
					case 27: // escape
						this.hide();
						break;
					default:
						this.request();
						break;
				}
			});

			// Click
			this.click = function(event) {
				event.preventDefault();

				value = $(event.target).parent().attr('data-value');

				if (value && this.items[value]) {
					this.select(this.items[value]);
				}
			}

			// Show
			this.show = function() {
				var pos = $(this).position();

				$(this).siblings('ul.dropdown-menu').css({
					top: pos.top + $(this).outerHeight(),
					left: pos.left
				});

				$(this).siblings('ul.dropdown-menu').show();
			}

			// Hide
			this.hide = function() {
				$(this).siblings('ul.dropdown-menu').hide();
			}

			// Request
			this.request = function() {
				clearTimeout(this.timer);

				this.timer = setTimeout(function(object) {
					object.source($(object).val(), $.proxy(object.response, object));
				}, 200, this);
			}

			// Response
			this.response = function(json) {
				html = '';

				if (json.length) {
					for (i = 0; i < json.length; i++) {
						this.items[json[i]['value']] = json[i];
					}

					for (i = 0; i < json.length; i++) {
						if (!json[i]['category']) {
							html += '<li data-value="' + json[i]['value'] + '"><a href="#">' + json[i]['label'] + '</a></li>';
						}
					}

					// Get all the ones with a categories
					var category = new Array();

					for (i = 0; i < json.length; i++) {
						if (json[i]['category']) {
							if (!category[json[i]['category']]) {
								category[json[i]['category']] = new Array();
								category[json[i]['category']]['name'] = json[i]['category'];
								category[json[i]['category']]['item'] = new Array();
							}

							category[json[i]['category']]['item'].push(json[i]);
						}
					}

					for (i in category) {
						html += '<li class="dropdown-header">' + category[i]['name'] + '</li>';

						for (j = 0; j < category[i]['item'].length; j++) {
							html += '<li data-value="' + category[i]['item'][j]['value'] + '"><a href="#">&nbsp;&nbsp;&nbsp;' + category[i]['item'][j]['label'] + '</a></li>';
						}
					}
				}

				if (html) {
					this.show();
				} else {
					this.hide();
				}

				$(this).siblings('ul.dropdown-menu').html(html);
			}

			$(this).after('<ul class="dropdown-menu"></ul>');
			$(this).siblings('ul.dropdown-menu').delegate('a', 'click', $.proxy(this.click, this));

		});
	}
})(window.jQuery);


sticky_header = true;
$(document).on('ready', function () 
{
	$('.selectpicker').selectpicker({});

		$(window).scroll(function() {
			if($(this).scrollTop() > 100) {
				$('#scroll_top_btn').fadeIn();	
				if (sticky_header) 
				{
					$('.header').addClass("sticky");	
					jQuery("body").css("marginTop", "150px");
				}
			} else {
				$('#scroll_top_btn').fadeOut();
				if (sticky_header) 
				{
					$('.header').removeClass("sticky");	
					jQuery("body").css("marginTop", "0px");
				}
			}
		});
	 
		$('#scroll_top_btn').click(function(e) {
			$('body,html').animate({scrollTop:0},500);
			e.preventDefault();
			return false;
		});
		
	  $(document).delegate('.spinner .btn:first-of-type','click', function() {
		$('.spinner input').val( Math.max(parseInt($('.spinner input').val(), 10) - 1, 1));
		if (jQuery("h2.price").attr("data-price"))
		{ 
		price = jQuery("h2.price");
		_price = eval(jQuery("h2.price").attr("data-price").replace(',','.'));
		_currency = jQuery("h2.price").attr("data-currency");
		if (_price) price.html((_price * $('.spinner input').val()).toLocaleString(_currency, { style: 'currency', currency: _currency,  maximumFractionDigits:2, minimumFractionDigits:2 }).replace(_currency, '').replace(jQuery(".currency").html().trim(), ''));				
		}
	  });
	  
	  $(document).delegate('.spinner .btn:last-of-type','click', function() {
		$('.spinner input').val( parseInt($('.spinner input').val(), 10) + 1);
		if (jQuery("h2.price").attr("data-price"))
	    { 
		price = jQuery("h2.price");
		_price = eval(jQuery("h2.price").attr("data-price").replace(',','.'));
		_currency = jQuery("h2.price").attr("data-currency");
		if (_price) price.html((_price * $('.spinner input').val()).toLocaleString(_currency, { style: 'currency', currency: _currency,  maximumFractionDigits:2,  minimumFractionDigits:2 }).replace(_currency, '').replace(jQuery(".currency").html().trim(), ''));
		}
	  });

	  $(document).delegate('#product .radio input[type=radio]','click', function() {
		//reset other radios
		jQuery("label", this.parentNode.parentNode.parentNode).removeClass("checked");
		if (this.checked) jQuery(this.parentNode).addClass("checked"); else jQuery(this.parentNode).removeClass("checked");
	  });
	
	if ($("#price-slider").length)  
	{
		$("#price-slider").slider({tooltip_split:true});
		$("#price-slider").slider('relayout');
	}	
	if (isMobile())
	{
		jQuery("li.dropdown-submenu").click(function(e)	
		{
			hasClass = jQuery(this).hasClass("open");
			jQuery("li.dropdown-submenu").removeClass("open");
			if (!hasClass) jQuery(this).addClass("open");
			return false;
			e.preventDefault();
});
		jQuery("li.dropdown-submenu li a").click(function(e)	
		{
			window.location = this.href;
			return true;
		});	
	}
});

var _is_mobile = undefined;

function isMobile()
{
	if (_is_mobile != undefined) return _is_mobile;
	a = navigator.userAgent||navigator.vendor||window.opera;

	if(
	 typeof window.orientation !== 'undefined'
	 || window.innerWidth <= 800 && window.innerHeight <= 600
	 || ('ontouchstart' in document.documentElement)
	 || (/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4)))
	 )
	 _is_mobile =  true; else _is_mobile = false;
	
	return _is_mobile;
}

function nico_grid(grid_element)
{
	var handler;		
	var options = {
	  autoResize: true, // This will auto-update the layout when the browser window is resized.
	  align:"left",
	  container: $('#' + grid_element), // Optional, used for some extra CSS styling
	  offset: 0,// Optional, the distance between grid items
	  itemWidth: jQuery('#' + grid_element + '.grid > div:first').outerWidth() - 1, // Optional, the width of a grid item
	  //fillEmptySpace: true // Optional, fill the bottom of each column with widths of flexible height
	};	    
		
//	  width = Math.round(($('#<?php echo $module_id;?>').outerWidth() - 20) / jQuery('.grid > div:first').width());
	  // Prepare layout options.
	    // Get a reference to your grid items.
	    if ($('#' + grid_element + ' > div').length < 1) return false;
	    
	    handler = $('#' + grid_element + ' > div');
		filters = $('.filters.' + grid_element  + ' li');

		handler.wookmark(options);
	    // Call the layout function.
	    setTimeout(function()
			{
//			    width = jQuery('#' + grid_element + '.grid > div:first').outerWidth() - 1;
//			    options.itemWidth =  width;
				handler.wookmark(options);
			}, 1000
		);
		/*handler.imagesLoaded(function() 
		{
				width = jQuery('.grid > div:first').outerWidth() - 1;
				options.width = options;
				handler.wookmark(options);
		});*/	

	    //jQuery(window).load(function() {handler.wookmark(options);});
	    jQuery(window).load(function() {handler.wookmark(options);});

	    /**
	     * When a filter is clicked, toggle it's active state and refresh.
	     */
	    var onClickFilter = function(event) {
	      var item = $(event.currentTarget),
		  activeFilters = [];

	      if (!item.hasClass('active')) {
		filters.removeClass('active');
	      }
	      item.toggleClass('active');

	      // Filter by the currently selected filter
	      if (item.hasClass('active')) {
		activeFilters.push(item.data('filter'));
	      }

	      handler.wookmarkInstance.filter(activeFilters);
	    }

	    // Capture filter click events.
	    filters.click(onClickFilter);    
}


function nico_carousel(module_id, cols_xs, cols_sm, cols_md, cols_lg)
{
		// store the slider in a local variable
	  var $window = $(window),
		  flexslider;    
		/*
	 function getGridSize<?php echo $module_id;?>() {
		return (window.innerWidth < 320) ? cols_xs:
			   (window.innerWidth < 767) ? cols_s,:
			   (window.innerWidth < 992) ? 12 / cols_md : 12 / cols_lg;
	  }*/

	//$window.load(function () {jQuery("#" + module_id + ".carousel > div").data('flexslider').resize();})  
	if ($("#" + module_id + '.carousel > div').length < 1) return false;

	nico_carousel_resize = function(cols_xs, cols_sm, cols_md, cols_lg) 
	{
		return ((window.innerWidth <= 320) ? 12 / cols_xs:
		   (window.innerWidth < 767) ? 12 / cols_sm:
		   (window.innerWidth < 992) ? 12 / cols_md : 12 / cols_lg);
	};
	$("#" + module_id + '.carousel > div').flexslider({
		animation:"slide",
		easing:"",
		direction:"horizontal",
		startAt:0,
		initDelay:0,
		slideshowSpeed:7000,
		animationSpeed:600,
		prevText:"",
		nextText:"",
		pauseText:"Pause",
		playText:"Play",
		pausePlay:false,
		controlNav:false,
		slideshow:false,
		animationLoop:true,
		randomize:false,
		smoothHeight:false,
		useCSS:true,
		pauseOnHover:true,
		pauseOnAction:true,
		touch:true,
		video:false,
		mousewheel:false,
		keyboard:false,
		itemWidth:jQuery("#" + module_id + '.carousel .slides > li > div:first').outerWidth(),
		minItems: nico_carousel_resize(cols_xs, cols_sm, cols_md, cols_lg), // use function to pull in initial value
		maxItems: nico_carousel_resize(cols_xs, cols_sm, cols_md, cols_lg)// use function to pull in initial value
	});
}

var nico_tabs_carousel_resize;
function nico_tabs_carousel(module_id, cols_xs, cols_sm, cols_md, cols_lg)
{
  if ($("#" + module_id + ' .carousel > div').length < 1) return false;
  // store the slider in a local variable
  var $window = $(window),
	  flexslider;    

	nico_tabs_carousel_resize = function(cols_xs, cols_sm, cols_md, cols_lg) 
	{
		return ((window.innerWidth <= 320) ? 12 / cols_xs:
		   (window.innerWidth < 767) ? 12 / cols_sm:
		   (window.innerWidth < 992) ? 12 / cols_md : 12 / cols_lg);
	};

    $("#" + module_id + '_tabs a').click(function (e) {
	    e.preventDefault();
	    $(this).tab('show');
	    //_flexslider = jQuery("#" + module_id + " .carousel > div");
	    if (flexslider != null) 
	    {
			flexslider.resize()
		}
    });
    
    $("#" + module_id + '_tabs a:first').tab('show');

	  $window.resize(function() 
	  {
		 if (flexslider != null && (data = flexslider.data('flexslider'))) data.vars.minItems = nico_tabs_carousel_resize(cols_xs, cols_sm, cols_md, cols_lg);
	  });
	  
	flexslider = $("#" + module_id + ' .carousel > div').flexslider({
		animation:"slide",
		easing:"",
		direction:"horizontal",
		startAt:0,
		initDelay:0,
		slideshowSpeed:7000,
		animationSpeed:600,
		prevText:"",
		nextText:"",
		pauseText:"Pause",
		playText:"Play",
		pausePlay:false,
		controlNav:false,
		slideshow:false,
		animationLoop:true,
		randomize:false,
		smoothHeight:false,
		useCSS:true,
		pauseOnHover:true,
		pauseOnAction:true,
		touch:true,
		video:false,
		mousewheel:false,
		keyboard:false,
		itemWidth:100,//jQuery("#" + module_id + ' .carousel > div:first').outerWidth() +  'px',
		minItems: nico_tabs_carousel_resize(cols_xs, cols_sm, cols_md, cols_lg), // use function to pull in initial value
		maxItems: nico_tabs_carousel_resize(cols_xs, cols_sm, cols_md, cols_lg)// use function to pull in initial value
	});
	
	if (flexslider != null) 
	{
		setTimeout(function () {flexslider.resize()}, 500);
	}	
}

function nico_sequence_slider(seq_module_id, autoplay, autoplay_interval)
{

	if ($("#sequence-" +  seq_module_id).length < 1) return false;
	function sequence_height()
	{
		$("#sequence-" + seq_module_id ).height($("#sequence-" + $seq_module_id + " .background:first").height());	
	}

	var sequenceOptions = {
        autoPlay: autoplay ,
        autoPlayDelay: autoplay_interval,
        pauseOnHover: true,
		hidePreloaderUsingCSS: true,                   
        preloader: true,
        hidePreloaderDelay: 500,
	
        nextButton: true,
        prevButton: true,
        pauseButton: false,
        animateStartingFrameIn: false,    
        navigationSkipThreshold: 750,
        preventDelayWhenReversingAnimations: true,
        fadeFrameWhenSkipped:false,
        /*moveActiveFrameToTop:false,*/
    };

    var sequence = $("#sequence-" +  seq_module_id).sequence(sequenceOptions).data("sequence");

	function youtube_control(frame, func)
    {
			//func = pauseVideo/playVideo;
			youtube = jQuery("iframe.youtube", frame);
			if (youtube.length)
			{
					youtube.get(0).contentWindow.postMessage('{"event":"command","func":"' + func + '","args":""}',"*"); 
			}
	}

    function vimeo_control(frame, func)
    {
			//func = pause/play;
			vimeo = jQuery("iframe.vimeo", frame);
			if (vimeo.length)
			{
				vimeo.get(0).contentWindow.postMessage('{"method":"' + func + '"}',"*"); 
			}
	}

	if (sequence) sequence.beforeNextFrameAnimatesIn = function()
	{
		youtube_control(sequence.currentFrame, "pauseVideo");
		youtube_control(sequence.nextFrame, "playVideo");

		vimeo_control(sequence.currentFrame, "pause");
		vimeo_control(sequence.nextFrame, "play");
	}
}

function nico_google_maps(module_id, lat, long, zoom, markers)
{
	if ($("#" +  module_id).length < 1) return false;
	var mapProp = 
	{
	  center:new google.maps.LatLng(lat, long),
	  zoom:zoom,
	  mapTypeId:google.maps.MapTypeId.ROADMAP
	};

	var map=new google.maps.Map(document.getElementById(module_id),mapProp);
	var infowindow = new google.maps.InfoWindow();
	
	var i;
	for (i in markers)
	{
		var m=new google.maps.Marker(
		{
		  position: new google.maps.LatLng(markers[i]['lat'], markers[i]['long']),
		  map: map
		});
		
		 google.maps.event.addListener(m, 'click', (function(m, i) {
			return function() {
			  infowindow.setContent(markers[i]['description']);
			  infowindow.open(map, m);
			}
		  })(m, i));
   }
}

function nico_magnific_popup()
{
	if (typeof jQuery.fn.magnificPopup == 'undefined')
	{
		jQuery("head").append('<link rel="stylesheet" property="stylesheet" type="text/css" href="catalog/view/javascript/jquery/magnific/magnific-popup.css" media="screen" /><script type="text/javascript" src="catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js">');
	}
	
	$(document).ready(function() {
		$('.image-additional > ul > li, .product-info .image').magnificPopup({
			type:'image',
			delegate: 'a',
			gallery: { 
				enabled:true 
			}
		});
	});
}


function nico_cloud_zoom()
{
	$.fn.CloudZoom.defaults = 
	{
		zoomWidth:"auto",
		zoomHeight:"auto",
		position:"inside",
		adjustX:0,
		adjustY:0,
		adjustY:"",
		tintOpacity:0.5,
		lensOpacity:0.5,
		titleOpacity:0.5,
		smoothMove:3,
		showTitle:false
	};				


	//add a small delay when loaded trough quickview
	if (jQuery("#cboxLoadedContent .container").length = 0)
		$('.cloud-zoom, .cloud-zoom-gallery').CloudZoom();
	else setTimeout(function ()
	{
		$('.cloud-zoom, .cloud-zoom-gallery').CloudZoom();
	}, 1000);
	 

	image_additional = $('.image-additional');
	
	if (image_additional.length)
	$(image_additional).flexslider({
		animation:"slide",
		direction:"horizontal",
		startAt:0,
		initDelay:0,
		slideshowSpeed:7000,
		animationSpeed:600,
		prevText:"",
		nextText:"",
		pauseText:"Pause",
		playText:"Play",
		pausePlay:false,
		controlNav:false,
		slideshow:false,
		animationLoop:true,
		randomize:false,
		smoothHeight:false,
		useCSS:true,
		pauseOnHover:true,
		pauseOnAction:true,
		touch:true,
		video:false,
		mousewheel:false,
		keyboard:false,
		itemWidth:74
	}).data('flexslider').resize();	 
}
function popup_checkbox(popup_module_id, check)
{
	if (check)
	Cookies.set(popup_module_id, "1" , { expires: 365 }); else 
	Cookies.set(popup_module_id, "", { expires: 365 });
};

function popup_close(popup_module_id)
{
	Cookies.set(popup_module_id, "1",{ expires: 365 });
};
