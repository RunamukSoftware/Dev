<?php
/**
 * @author William Sergio Minossi
 * @copyright 2017
 */
 
//update_option('verticalmenu_optin', '');
 
// $activated = '';

ob_start();

$verticalmenu_old = get_site_option('verticalmenu_update_theme', '0');

if (isset($_COOKIE["bill_update_vm"]) ) {
    $host_name = trim(strip_tags($_SERVER['HTTP_HOST']));
    $host_name = strtolower($host_name);   
    $mycookie = $_COOKIE["bill_update_vm"];
    $pieces = explode("-", $mycookie);
    $cookie_domain = strip_tags(trim($pieces[1]));
    $verticalmenu_update_theme = '';
    if (!empty($cookie_domain)) {
        $pos = strpos($cookie_domain, $host_name);
        if ($pos !== false)
            $verticalmenu_update_theme = strip_tags($pieces[0]);
    }
    if ($verticalmenu_update_theme !== $verticalmenu_old) {
        if (get_option('verticalmenu_update_theme') !== false) {
            // The option already exists, so we just update it.
            update_option('verticalmenu_update_theme', $verticalmenu_update_theme);
        } else {
            // The option hasn't been added yet. We'll add it with $autoload set to 'no'.
            add_option('verticalmenu_update_theme', $verticalmenu_update_theme);
        }
    }
    

} // Cookie exist


//  $verticalmenu_update_theme = '';
  
if ( get_option( 'verticalmenu_optin' ) !== false ) {
   $activated =  get_option('verticalmenu_optin', '') ;
} 

if (isset($_COOKIE["bill_activated_vm"]) and $activated != '1') {
    $host_name = trim(strip_tags($_SERVER['HTTP_HOST']));
    $host_name = strtolower($host_name);   
    $mycookie = $_COOKIE["bill_activated_vm"];
    $pieces = explode("-", $mycookie);
    $cookie_domain = strip_tags(trim($pieces[1]));
    $activated = '';
    if (!empty($cookie_domain)) {
        $pos = strpos($cookie_domain, $host_name);
        if ($pos !== false)
            $activated = strip_tags($pieces[0]);
    }
    if ($activated == '0' or $activated == '1') {
        if (get_option('verticalmenu_optin') !== false) {
            // The option already exists, so we just update it.
            update_option('verticalmenu_optin', $activated);
        } else {
            // The option hasn't been added yet. We'll add it with $autoload set to 'no'.
            add_option('verticalmenu_optin', $activated);
        }
    }

} // Cookie exist


 //  $activated = '';


add_action( 'admin_menu', 'verticalmenu_add_admin_menu' );
add_action( 'admin_init', 'verticalmenu_settings_init' );
function verticalmenu_enqueue_scripts() {

        
        if(memory_status())
        {
           	wp_register_script( 'help-manager',VERTICALMENUURL.'/js/help-manager.js' , array( 'jquery' ), VERTICALMENUVERSION, true );
    		wp_enqueue_script( 'help-manager' );
         
            wp_enqueue_script('jquery-ui-core');
            wp_enqueue_script('jquery-ui-dialog');
            wp_register_style( 'bill-jquery-help', 'http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css', array(), '20120208', 'all' );
            wp_enqueue_style( 'bill-jquery-help' );

        }
                   
        wp_register_script( 'fix-config-manager',VERTICALMENUURL.'/js/fix-config-manager.js' , array( 'jquery' ), VERTICALMENUVERSION, true );
    	wp_enqueue_script( 'fix-config-manager' );
 
        
      	wp_enqueue_style( 'bill-help' , VERTICALMENUURL.'/css/help.css');

    	wp_register_script( 'bill-lib',VERTICALMENUURL.'/js/bill-lib.js' , array( 'jquery' ), VERTICALMENUVERSION );
		wp_enqueue_script( 'bill-lib' );
        wp_register_style( 'bill-lib-css',VERTICALMENUURL.'/css/bill-lib.css', array(), '20170404');
        wp_enqueue_style( 'bill-lib-css' );
}
add_action('admin_init', 'verticalmenu_enqueue_scripts');
function verticalmenu_add_admin_menu(  ) { 
    global $vmtheme_hook;
    $vmtheme_hook = add_theme_page( 'Vertical Menu', 'Vertical Menu Help', 'manage_options', 'vertical_menu', 'verticalmenu_options_page' );
    add_action('load-'.$vmtheme_hook, 'vmtheme_contextual_help');     
}
function verticalmenu_settings_init(  ) { 
	register_setting( 'verticalmenu', 'verticalmenu_settings' );
}
function verticalmenu_options_page(  ) { 
    global $activated, $verticalmenu_update_theme;
 
            $wpversion = get_bloginfo('version');
            $current_user = wp_get_current_user();
            $plugin = plugin_basename(__FILE__); 
            $email = $current_user->user_email;
            $username =  trim($current_user->user_firstname);
            $user = $current_user->user_login;
            $user_display = trim($current_user->display_name);
            if(empty($username))
               $username = $user;
            if(empty($username))
               $username = $user_display;
            $theme = wp_get_theme( );
            $themeversion = $theme->version ; 
            $memory['limit'] = (int) ini_get('memory_limit') ;	
            $memory['usage'] = function_exists('memory_get_usage') ? round(memory_get_usage() / 1024 / 1024, 0) : 0;
            
            if(defined("WP_MEMORY_LIMIT"))
                $memory['wplimit'] =  WP_MEMORY_LIMIT ;
            else
                 $memory['wplimit'] = '';
 
   
           $verticalmenumypath = VERTICALMENUURL.'/inc/fixconfig.php';
           $verticalmeurlkey = urlencode(substr(NONCE_KEY,0,10));
           $verticalmenumyrestore = VERTICALMENUURL.'/public/restore-config.php?key='.$verticalmeurlkey;
           
           

            
  ?>
  
  <!-- ///////////// Fix Config /////////////////  -->


    <div id="themefix-wpconfig" style="display: none;">
    <div class="themefix-message-wrap" style="">
     <div class="themefix-message" style="">
     
     
     If your server allow us, we can try to fix your file wp-config.php to release more memory.
     <br />
     <strong>Please, copy the url blue below to safe place before to proceed.</strong>
     
     <br />  
     Use the url only to undo this operation if you've problem accessing your site after the update.
     <br />
     <br />
     After Copy the URL, click UPDATE to proceed or Cancel to abort.
     <br />   <br />
     <textarea rows="3" id="restore_wpconfig" name="restore_wpconfig" style="width:100%; color: blue;" ><?php echo $verticalmenumyrestore;?></textarea>
     <textarea rows="6" id="feedback_wpconfig" name="feedback_wpconfig" style="width:100%; font-weight: bold;" ></textarea>

                 <?php
                 if($activated != '1' )
                 {
  ?>
                    <br /><br /> 
                 <!--    <input type="checkbox" class="anonymous20" value="anonymous" /><small>Participate anonymous <?php _e("(In this case, we are unable to email you)","verticalmenu");?></small> -->
           <?php } ?>  
                 <br /><br /> 			
		    			<a href="#" class="button button-primary button-close-wpconfig"><?php _e("Update","verticalmenu");?></a>
		    			<a href="#" class="button button-primary button-cancell-wpconfig"><?php _e("Cancel","verticalmenu");?></a>

                        <img alt="aux" src="/wp-admin/images/wpspin_light-2x.gif" id="verticalmenu-imagewait20" />
		                <input type="hidden" id="email" name="email" value="<?php echo $email;?>" />
   		                <input type="hidden" id="url_config" name="url_config" value="<?php echo $verticalmenumypath;?>" />
  		                <input type="hidden" id="verticalmeurlkey" name="verticalmeurlkey" value="<?php echo $verticalmeurlkey;?>" />


                 <br /><br />
     </div>
    </div>
  </div>

<!-- ///////////// End Fix config /////////////////  -->


  <!-- Support -->
  
  <div class="bill-support-verticalmenu" style="display:none">
              <div class="bill-vote-gravatar"><a href="http://profiles.wordpress.org/sminozzi" target="_blank"><img src="https://en.gravatar.com/userimage/94727241/31b8438335a13018a1f52661de469b60.jpg?size=100" alt="Bill Minozzi" width="70" height="70"></a></div>
		    	<div class="bill-vote-message">
                 <h4><?php _e("Send  messages to our Technical Support","verticalmenu");?></h4>
                 <?php _e("Please, follow this instructions:","verticalmenu");?>
                 <br />
                 <?php _e("1- No javascript, php or html code.","verticalmenu");?>
                 <br />
                 <?php _e("2- Try to explain as clearly as you can the issue you are having and what you were trying to do when the problem occurred.","verticalmenu");?>
                 <br /><br />
                 <?php _e("Our support center works Monday - Friday (9:00 to 17:00) and we are in Europe (London time zone) Please give us 1 business day to answer.","verticalmenu");?>
                 <br /><br />
 
                 <strong>
                 
                 <?php _e("* Check your email account","verticalmenu"); echo ': '.$email;?>
                 <br />
                 <?php _e("(also SPAM FOLDER) for our response.","verticalmenu");?>
              
                 
                 </strong>
                 <br /><br /> 
                 <textarea rows="4" cols="50" id="explanation" name="explanation" placeholder="<?php _e("type here your question...","verticalmenu");?>" ></textarea>
  
                 <br /><br /> 			
		    			<a href="#" class="button button-primary button-close-spsubmit"><?php _e("Yes, Submit","verticalmenu");?></a>
                        <img alt="aux" src="/wp-admin/images/wpspin_light-2x.gif" id="verticalmenu-imagewait3" style="visibility:hidden" />
		    			<a href="#" class="button button-Secondary button-close-spdialog"><?php _e("Cancel","verticalmenu");?></a>
                        <input type="hidden" id="version" name="version" value="<?php echo $themeversion;?>" />
		                <input type="hidden" id="email" name="email" value="<?php echo $email;?>" />
		                <input type="hidden" id="username" name="username" value="<?php echo $username;?>" />
		                <input type="hidden" id="produto" name="produto" value="verticalmenu" />
		                <input type="hidden" id="wpversion" name="wpversion" value="<?php echo $wpversion;?>" />
   		                <input type="hidden" id="activated" name="activated" value="<?php echo $activated;?>" />
		                <input type="hidden" id="limit" name="limit" value="<?php echo $memory['limit'];?>" />
		                <input type="hidden" id="wplimit" name="wplimit" value="<?php echo $memory['wplimit'];?>" />
   		                <input type="hidden" id="usage" name="usage" value="<?php echo $memory['usage'];?>" />
                 <br /><br />
               </div>
    </div>
    
    <!-- Feedback -->
 
 
        
      <div class="bill-feedback-verticalmenu" style="display:none">
              <div class="bill-vote-gravatar"><a href="http://profiles.wordpress.org/sminozzi" target="_blank"><img src="https://en.gravatar.com/userimage/94727241/31b8438335a13018a1f52661de469b60.jpg?size=100" alt="Bill Minozzi" width="70" height="70"></a></div>
		    	<div class="bill-vote-message">
                 <h4><?php _e("Please, let us know you, your site and your feedback.","verticalmenu");?></h4>
                 <?php _e("Hi, my name is Bill Minozzi, and I am developer of theme verticalmenu.","verticalmenu");?>
                 <br />
                 <?php _e("We appreciate your help in making our theme better.","verticalmenu");?>
                 <br />
                 <?php _e("We are building the best service we can for you but we can't promise it will be perfect or if we will include all suggestions.","verticalmenu");?>
                 <br /><br />             
                 <strong><?php _e("Thank You!","verticalmenu");?></strong>
                 <br /><br /> 
                 <textarea rows="4" cols="50" id="explanationfb" name="explanation" placeholder="<?php _e("type here yours sugestions ...","verticalmenu");?>" ></textarea>
                 <?php

                 if($activated != '1' )
                 {
                    
  ?>
                    <br /><br /> 
                    <input type="checkbox" class="anonymous2" value="anonymous" /><small>Participate anonymous <?php _e("(In this case, we are unable to email you)","verticalmenu");?></small>
           <?php } ?>  
                 <br /><br /> 			
		    			<a href="#" class="button button-primary button-close-fbsubmit"><?php _e("Yes, Submit","verticalmenu");?></a>
                        <img alt="aux" src="/wp-admin/images/wpspin_light-2x.gif" id="verticalmenu-imagewait2" style="visibility:hidden" />
		    			<a href="#" class="button button-Secondary button-close-fbdialog"><?php _e("Cancel","verticalmenu");?></a>
                        <input type="hidden" id="version" name="version" value="<?php echo $themeversion;?>" />
		                <input type="hidden" id="email" name="email" value="<?php echo $email;?>" />
		                <input type="hidden" id="username" name="username" value="<?php echo $username;?>" />
		                <input type="hidden" id="produto" name="produto" value="verticalmenu" />
		                <input type="hidden" id="wpversion" name="wpversion" value="<?php echo $wpversion;?>" />
		                <input type="hidden" id="limit" name="limit" value="<?php echo $memory['limit'];?>" />
		                <input type="hidden" id="wplimit" name="wplimit" value="<?php echo $memory['wplimit'];?>" />
   		                <input type="hidden" id="usage" name="usage" value="<?php echo $memory['usage'];?>" />
                 <br /><br />
               </div>
    </div>
    
    <!-- Begin Page -->
    
<div id = "verticalmenu-theme-help-wrapper">   
  
   
     <div id="verticalmenu-not-activated"></div>
         
     <div id="verticalmenu-logo">
       <img  alt="aux" id="verticalmenu-logo-image" src="<?php echo get_template_directory_uri()?>/images/logo-horizontal.png" />
     </div>
     <div id="verticalmenu_help_title">
         Help and Support Page
     </div> 
     
    
 <?php
if( isset( $_GET[ 'tab' ] ) ) 
    $active_tab = $_GET[ 'tab' ];
else
   $active_tab = 'dashboard';
?>
    
    <h2 class="nav-tab-wrapper">
    <a href="?page=vertical_menu&tab=dashboard" class="nav-tab">Dashboard</a>
    <a href="?page=vertical_menu&tab=faq" class="nav-tab">Faq</a>
    <a href="?page=vertical_menu&tab=memory" class="nav-tab">Memory</a>
    <a href="?page=vertical_menu&tab=freebies" class="nav-tab">Freebies</a>

    </h2>
 
    
<?php  if($active_tab == 'memory') {     

   require_once (VERTICALMENUPATH . '/inc/memory.php');
	
} 
elseif($active_tab == 'faq')
{ 
    require_once (VERTICALMENUPATH . '/inc/faq.php');
}
elseif($active_tab == 'freebies')
{ 
    require_once (VERTICALMENUPATH . '/inc/freebies.php');
}
else
{ 
    require_once (VERTICALMENUPATH . '/inc/dashboard.php');
}



 echo '</div> <!-- "verticalmenu-theme_help-wrapper"> -->';

} // end Function verticalmenu_options_page

function vmtheme_contextual_help()
{
    
    if(!memory_status())
      return;
      
    $screen = get_current_screen();
    $myhelp = '<br><big>';
    $myhelp .= __('Vertical Menu is a responsive and double menu theme (vertical or horizontal), easy-to-use WordPress theme.',
        'verticalmenu');
    $myhelp .= '<br />';
    $myhelp .= __('You can find also our complete Theme OnLine Guide', 'verticalmenu').' ';
    $myhelp .= '<a href="http://verticalmenu.eu/guide/" target="_self"> ';
    $myhelp .= __('here', 'verticalmenu');
    $myhelp .= '.</a></big>';
    $options = '<big><br />';  
    $options.= __('Vertical Menu Theme has an advanced panel that is loaded with options.', 'verticalmenu');
    $options .= '<br />';
    $options .= __("Go to Appearance > Customize and take a look. We've organized them into logical sets and have given  descriptions for items that need it, most things are self explanatory. Be sure to hit Save Changes to save your settings once you are done.", 'verticalmenu');
    $options .= '<br /></big>';
    $home = '<big><br />';  
    $home .= __("Once you have created your home page, you need to select it to show up as the home page. To do this, follow the steps below.", 'verticalmenu');
    $home .= '<br />';
    $home .= __("Navigate to Settings > Reading", 'verticalmenu');
    $home .= '<br />';
    $home .= __("Select A Static Page for Front Page Displays", 'verticalmenu');
    $home .= '<br />';
    $home .= __("Select your new home page for the Front Page", 'verticalmenu');
    $home .= '<br />';
    $home .= __("This is also the same spot you select the Blog page", 'verticalmenu');
    $home .= '<br />';
    $home .= __("Save", 'verticalmenu');
    $home .= '<br /></big>'; 
    $menu = '<big><br />';  
    $menu .= __("Go to Dashboard  Appearence => Customize  => Menus and setup the menu.", 'verticalmenu');
    $menu .= '<br />';
    $menu .= __("Here is the wordpress help:", 'verticalmenu');
    $menu .= '<br />';
    $menu .= '<a href="https://codex.wordpress.org/WordPress_Menu_User_Guide">';
    $menu .= __("https://codex.wordpress.org/WordPress_Menu_User_Guide", 'verticalmenu');
    $menu .= '</a><br /></big>';    
    $logo = '<big><br />';  
    $logo .= __("Go to Dashboard  Appearence => Customize  => Site Identity and setup the logo.", 'verticalmenu');
    $logo .= '<br />';
    $topinfo = '<big><br />';  
    $topinfo .= __("Go to Dashboard  Appearence => Customize => Customize => Top Page Settings.", 'verticalmenu');
    $topinfo .= '<br />';
    $footer = '<big><br />';  
    $footer .= __("Go to Dashboard  Appearence => Customize => Customize => Footer Copyright.", 'verticalmenu');
    $footer .= '<br />';
    $screen->add_help_tab(array(
        'id' => 'bd-overview-tab',
        'title' => __('Overview', 'verticalmenu'),
        'content' => '<p>' . $myhelp . '</p>',
        ));
        $screen->add_help_tab(array(
        'id' => 'bd-overview-tab2',
        'title' => __('Theme Options', 'verticalmenu'),
        'content' => '<p>' . $options . '</p>',
        ));
        $screen->add_help_tab(array(
        'id' => 'bd-overview-tab4',
        'title' => __('Setting up the Home', 'verticalmenu'),
        'content' => '<p>' . $home . '</p>',
        ));
        $screen->add_help_tab(array(
        'id' => 'bd-overview-tab5',
        'title' => __('Setting up the Menu', 'verticalmenu'),
        'content' => '<p>' . $menu . '</p>',
        ));
        $screen->add_help_tab(array(
        'id' => 'bd-overview-tab6',
        'title' => __('Setting up te Logo', 'verticalmenu'),
        'content' => '<p>' . $logo . '</p>',
        ));
        $screen->add_help_tab(array(
        'id' => 'bd-overview-tab7',
        'title' => __('Setting Top Info', 'verticalmenu'),
        'content' => '<p>' . $topinfo . '</p>',
        ));
        $screen->add_help_tab(array(
        'id' => 'bd-overview-tab8',
        'title' => __('Footer Copyright', 'verticalmenu'),
        'content' => '<p>' . $footer . '</p>',
        ));
}
ob_end_clean();
?>