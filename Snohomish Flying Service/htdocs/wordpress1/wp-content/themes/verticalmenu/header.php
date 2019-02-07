<?php /**
 * The template for displaying the header
 *
 * Displays all of the head element and everything up until the "site-content" div.
 *
 * @package verticalmenu
 * 
 * @since verticalmenu 1.0
 */ ?><!DOCTYPE html>
<html <?php language_attributes(); ?> class="no-js">
<head>
	<meta charset="<?php bloginfo('charset'); ?>">
	<meta name="viewport" content="width=device-width">
	<link rel="profile" href="http://gmpg.org/xfn/11">
	<link rel="pingback" href="<?php bloginfo('pingback_url'); ?>">
	<?php wp_head(); ?>
</head>
<body <?php body_class(); ?>>
<div id="wrapper">
<div id="page" class="hfeed site">
	<a class="skip-link screen-reader-text" href="#content"><?php _e('Skip to content',
'verticalmenu'); ?></a>


	<div id="sidebar" class="sidebar">
		<header id="masthead" class="site-header"> <!-- role="banner"> -->
			<div class="site-branding">
              <div class="site-logo"> 
                  <?php verticalmenu_the_custom_logo(); ?>
              </div>
                    <?php
 					if ( is_front_page() && is_home() ) : ?>
						<h1 class="site-title"><a href="<?php echo esc_url( home_url( '/' ) ); ?>" rel="home"><?php bloginfo( 'name' ); ?></a></h1>
					<?php else : ?>
						<p class="site-title"><a href="<?php echo esc_url( home_url( '/' ) ); ?>" rel="home"><?php bloginfo( 'name' ); ?></a></p>
					<?php endif;
					$description = get_bloginfo( 'description', 'display' ); ?>
						<p class="site-description"><?php echo esc_html($description); ?></p>
				<button class="secondary-toggle"><?php _e('Menu and widgets', 'verticalmenu'); ?></button>
			</div><!-- .site-branding -->
		</header><!-- .site-header -->
		<?php get_sidebar(); ?>
	</div><!-- .sidebar -->
    
    
    
	<div id="content" class="site-content">
    
    
             <?php $verticalmenu_loading = esc_attr(get_theme_mod('verticalmenu_loading','1'));

                   if($verticalmenu_loading == 1)
                   {
                        ?>
                     	<div id="display_loading" >
			         	<img src="<?php echo get_template_directory_uri() . '/images/ajax-loader.gif' ?>" alt="loading icon" />
		            	</div>        
                        
            <?php  } ?>
    
            
   <div id="top_header" >
            <div id="header_top_left" >
            <?php 
             $vertical_icon_color = esc_attr(get_theme_mod('verticalmenu_topinfo_color','gray'));
             $vertical_topinfo_color = esc_attr($vertical_icon_color);
             $vertical_topinfo_email = get_theme_mod('verticalmenu_topinfo_email','');
             $vertical_topinfo_phone = get_theme_mod('verticalmenu_topinfo_phone','');
             $vertical_topinfo_hours = get_theme_mod('verticalmenu_topinfo_hours','');
             $verticalmenu_topinfo_email_link = get_theme_mod('verticalmenu_topinfo_email_link','');

 
 
              if(!empty($vertical_topinfo_phone))
                {  echo '<span class="genericon genericon-phone" title="genericon-phone"></span>';
                   echo '<div class="vertical_topinfo_text">'.esc_html($vertical_topinfo_phone).'</div>';
                }
             if(!empty($vertical_topinfo_email))
                {
                    echo '<span class="genericon genericon-mail" title="genericon-mail"></span>';
                    echo '<div class="vertical_topinfo_text">';
                    if($verticalmenu_topinfo_email_link <> '')
                      {
                         echo '<a href="'.$verticalmenu_topinfo_email_link;
                      }
                    else
                    {
                         echo '<a href="mailto:';
                         echo $vertical_topinfo_email;
                         
                    }  
                       
                    echo '">';
                    echo $vertical_topinfo_email;
                    echo '</a>';
                    echo '</div>';
                }
             if(!empty($vertical_topinfo_hours))
                {
                     echo '<span class="genericon genericon-time"></span>';
                     echo '<div class="vertical_topinfo_text">'.esc_html($vertical_topinfo_hours).'</div>';
                }
              ?>
            </div>
            <div id="header_top_right" >
            <div class="verticalmenu_my_shopping_cart"> 
             <?php global $woocommerce;
if (isset($woocommerce)) {
    // get cart quantity
    $qty = $woocommerce->cart->get_cart_contents_count();
    // get cart total
    $total = $woocommerce->cart->get_cart_total();
    // get cart url
    $cart_url = esc_url($woocommerce->cart->get_cart_url());
    if ($qty > 0)
        echo '<a href="' . $cart_url . '"><img src="' . get_template_directory_uri() .
            '/images/cart.png" alt="Cart" width="32" height="32" /></a>';
    // if multiple products in cart

    if ($qty > 1)
        echo '<a href="' . $cart_url . '">' . ' ' . $qty . ' '. __('products', 'verticalmenu') .' | ' . $total .
            '</a>';
    // if single product in cart
    if ($qty == 1)
        echo '<a href="' . $cart_url . '"> 1 '. __('product', 'verticalmenu'). ' | ' . $total . '</a>';

} ?> 
            </div> <!-- #verticalmenu_shopping_cart --> 
       </div>  <!-- top_header_widgets right -->
      </div>  <!-- top_header -->
    <div id="wrap_top_menu">
            <!--  Menu -->
            <div id="verticalmenu_navbar"> <!-- class="top-verticalmenu_navbar"> -->
				<nav id="site-top-navigation" class="navigation primary-navigation">  <!-- role="navigation"> -->							
					<?php     
                    wp_nav_menu(array(
                    'theme_location' => 'primary', 
                    'menu_class' =>'top-nav-menu')); ?>					
				</nav><!-- #site-navigation -->
            </div><!-- #verticalmenu_navbar -->
          <!--  Fim Menu -->
          
 </div> <!--  wrap_top_menu -->
  