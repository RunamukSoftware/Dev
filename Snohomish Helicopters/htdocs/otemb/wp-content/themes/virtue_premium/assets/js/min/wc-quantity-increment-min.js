jQuery(function($){$("div.quantity:not(.buttons_added), td.quantity:not(.buttons_added)").addClass("buttons_added").append('<input type="button" value="+" class="plus" />').prepend('<input type="button" value="-" class="minus" />'),$(document).on("updated_cart_totals",function(){$("div.quantity:not(.buttons_added), td.quantity:not(.buttons_added)").addClass("buttons_added").append('<input type="button" value="+" class="plus" />').prepend('<input type="button" value="-" class="minus" />')}),$(document).on("click",".plus, .minus",function(){var t=$(this).closest(".quantity").find(".qty"),a=parseFloat(t.val()),n=parseFloat(t.attr("max")),s=parseFloat(t.attr("min")),u=t.attr("step");a&&""!==a&&"NaN"!==a||(a=0),""!==n&&"NaN"!==n||(n=""),""!==s&&"NaN"!==s||(s=0),"any"!==u&&""!==u&&void 0!==u&&"NaN"!==parseFloat(u)||(u=1),$(this).is(".plus")?n&&(n==a||a>n)?t.val(n):t.val(a+parseFloat(u)):s&&(s==a||s>a)?t.val(s):a>0&&t.val(a-parseFloat(u)),t.trigger("change")})});