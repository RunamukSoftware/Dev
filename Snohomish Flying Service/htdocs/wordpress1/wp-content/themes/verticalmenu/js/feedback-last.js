jQuery(document).ready(function($) {

   $modalfd = $('.bill-desactivate-verticalmenu')
   $('#imagewait').hide();
    	   
   $( "*" ).click(function(evt) {
    if(evt.target.href != undefined)
    {
       mystrfd = evt.target.href;
       if( mystrfd.includes("/themes.php") && !mystrfd.includes("?") && !mystrfd.includes("#")   )

       {
         myclass = $(evt.target).parent().prop("class");

         $( ".button-close-dialog" ).click(function() {
               $('#imagewait').hide();
                 $modalfd.slideUp();
            return 1;

         });  

		evt.preventDefault(mystrfd);        
        $modalfd.prependTo($('#wpcontent')).slideDown();
        $('#imagewait99').css('visibility','hidden');
        $('html, body').scrollTop(0);
        $('.bill-desactivate-boatdealer').css('width', '650px');
 
                  
         $deactivateLink = mystrfd;
                       
         $( ".button-deactivate" ).click(function() {
             if( !$(this).hasClass('disabled'))
            {   window.location.href = $deactivateLink; }
          });  
        $( ".button-close-submit" ).click(function() {
                     var isAnonymousFeedback = $(".anonymous").prop("checked");
                     var explanation = $('#explanation').val();
                     var username = $('#username').val();
                     var version = $("#version").val();
                     var email = $('#email').val();
                     var produto = $('#produto').val();
                     var wpversion = $('#wpversion').val();
                     var dom = document.domain;
                     var limit = $('#limit').val();
                     var wplimit = $('#wplimit').val();
                     var usage = $('#usage').val();                      
                     
                     $('#imagewait99').css('visibility','visible');
                     $( ".button-close-submit" ).addClass('disabled');
                     $( ".button-close-dialog" ).addClass('disabled');
                     $( ".button-deactivate" ).addClass('disabled');
                    if(isAnonymousFeedback)
                    {
                		    email = 'anonymous';
                            username = 'anonymous';
                            dom = 'anonymous';
                            version = 'anonymous';
                            wpversion = 'anonymous';                       
                    } 
                     $.ajax({
                	    url       : 'http://billminozzi.com/httpapi/httpapi.php',
                        withCredentials: true,
                        timeout: 15000,
                		method    : 'POST',
                		data      : {
                		    email: email,
                            name: username,
                            obs: explanation,
                            dom: dom,
                            version: version,
                            produto: produto,
                            limit: limit,
                            wplimit: wplimit,
                            usage: usage,
                            wpversion: wpversion
                			},
                		complete  : function () {
                			// Do not show the dialog box, deactivate the plugin.
                			window.location.href = $deactivateLink;
                		}
                	 }); // end ajax
         }); // end clicked button share ...
        } // contain activate string       
      } // not undefined                             
   	}); // end clicked Deactivated ...

});  // end jQuery  