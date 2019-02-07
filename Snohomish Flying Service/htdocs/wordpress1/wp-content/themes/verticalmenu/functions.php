<?php
/**
 * verticalmenu functions and definitions
 *
 */
/**
 * Set the content width based on the theme's design and stylesheet.
 *
 * @since verticalmenu 1.0
 */
if ( ! isset( $content_width ) ) {
	$content_width = 660;
}
/**
 * verticalmenu only works in WordPress 4.1 or later.
 */
if ( version_compare( $GLOBALS['wp_version'], '4.1-alpha', '<' ) ) {
	require get_template_directory() . '/inc/back-compat.php';
}
//////////// Begin New Functions
if( !function_exists('get_parent_theme_file_path'))
{
    function get_parent_theme_file_path( $file = '' ) {
    	$file = ltrim( $file, '/' );
    	if ( empty( $file ) ) {
    		$path = get_template_directory();
    	} else {
    		$path = get_template_directory() . '/' . $file;
    	}
    	return apply_filters( 'parent_theme_file_path', $path, $file );
    }
}
if( !function_exists('get_parent_theme_file_uri'))
{
    function get_parent_theme_file_uri( $file = '' ) {
    	$file = ltrim( $file, '/' );
    	if ( empty( $file ) ) {
    		$url = get_template_directory_uri();
    	} else {
    		$url = get_template_directory_uri() . '/' . $file;
    	}
    	return apply_filters( 'parent_theme_file_uri', $url, $file );
    }
}
if( !function_exists('get_theme_file_uri'))
{
    function get_theme_file_uri( $file = '' ) {
    	$file = ltrim( $file, '/' );
    	if ( empty( $file ) ) {
    		$url = get_stylesheet_directory_uri();
    	} elseif ( file_exists( get_stylesheet_directory() . '/' . $file ) ) {
    		$url = get_stylesheet_directory_uri() . '/' . $file;
    	} else {
    		$url = get_template_directory_uri() . '/' . $file;
    	}
    	return apply_filters( 'theme_file_uri', $url, $file );
    }
}
if( !function_exists('get_theme_file_path'))
{
    function get_theme_file_path( $file = '' ) {
        $file = ltrim( $file, '/' );
        if ( empty( $file ) ) {
            $path = get_stylesheet_directory();
        } elseif ( file_exists( get_stylesheet_directory() . '/' . $file ) ) {
            $path = get_stylesheet_directory() . '/' . $file;
        } else {
            $path = get_template_directory() . '/' . $file;
        }
        return apply_filters( 'theme_file_path', $path, $file );
    } 
}   
/////////////// end new functions
define('VERTICALMENUURL', get_theme_file_uri() );
define('VERTICALMENUPATH', get_theme_file_path() );
$theme = wp_get_theme( );
define('VERTICALMENUVERSION', $theme->version );
define('SITEURL', get_site_url() );
if ( ! function_exists( 'verticalmenu_setup' ) ) :
/**
 * Sets up theme defaults and registers support for various WordPress features.
 *
 * Note that this function is hooked into the after_setup_theme hook, which
 * runs before the init hook. The init hook is too late for some features, such
 * as indicating support for post thumbnails.
 *
 * @since verticalmenu 1.0
 */
function verticalmenu_setup() {
	/*
	 * Make theme available for translation.
	 * Translations can be filed in the /languages/ directory.
	 * If you're building a theme based on verticalmenu, use a find and replace
	 * to change 'verticalmenu' to the name of your theme in all the template files
	 */
	load_theme_textdomain( 'verticalmenu', get_template_directory() . '/languages' );
	// Add default posts and comments RSS feed links to head.
	add_theme_support( 'automatic-feed-links' );
	/*
	 * Let WordPress manage the document title.
	 * By adding theme support, we declare that this theme does not use a
	 * hard-coded <title> tag in the document head, and expect WordPress to
	 * provide it for us.
	 */
	add_theme_support( 'title-tag' );
	/*
	 * Enable support for Post Thumbnails on posts and pages.
	 *
	 * See: https://codex.wordpress.org/Function_Reference/add_theme_support#Post_Thumbnails
	 */
	add_theme_support( 'post-thumbnails' );
	set_post_thumbnail_size( 825, 510, true );
	/*
	 * Switch default core markup for search form, comment form, and comments
	 * to output valid HTML5.
	 */
	add_theme_support( 'html5', array(
		'search-form', 'comment-form', 'comment-list', 'gallery', 'caption'
	) );
	/*
	 * Enable support for Post Formats.
	 *
	 * See: https://codex.wordpress.org/Post_Formats
	 */
	add_theme_support( 'post-formats', array(
		'aside', 'image', 'video', 'quote', 'link', 'gallery', 'status', 'audio', 'chat'
	) );
	/*
	 * Enable support for custom logo.
	 *
	 * @since verticalmenu 1.0
	 */
	add_theme_support( 'custom-logo', array(
		'height'      => 300,
		'width'       => 300,
		'flex-height' => true,
	) );
	$color_scheme  = verticalmenu_get_color_scheme();
	$default_color = trim( $color_scheme[0], '#' );
	// Setup the WordPress core custom background feature.
	add_theme_support( 'custom-background', apply_filters( 'verticalmenu_custom_background_args', array(
		'default-color'      => $default_color,
		'default-attachment' => 'fixed',
	) ) );
	/*
	 * This theme styles the visual editor to resemble the theme style,
	 * specifically font, colors, icons, and column width.
	 */
	add_editor_style( array( 'css/editor-style.css', 'genericons/genericons.css') );
}
endif; // verticalmenu_setup
add_action( 'after_setup_theme', 'verticalmenu_setup' );
/**
  *
 * @since verticalmenu 1.0
 *
 * @link https://codex.wordpress.org/Function_Reference/register_sidebar
 */
/**
 * JavaScript Detection.
 *
 * Adds a `js` class to the root `<html>` element when JavaScript is detected.
 *
 * @since verticalmenu 1.1
 */
function verticalmenu_javascript_detection() {
	echo "<script>(function(html){html.className = html.className.replace(/\bno-js\b/,'js')})(document.documentElement);</script>\n";
}
add_action( 'wp_head', 'verticalmenu_javascript_detection', 0 );
/**
 * Enqueue scripts and styles.
 *
 * @since verticalmenu 1.0
 */
function verticalmenu_scripts() {
	// Add Genericons, used in the main stylesheet.
	wp_enqueue_style( 'genericons', get_template_directory_uri() . '/genericons/genericons.css', array(), '3.2' );
	// Load our main stylesheet.
	wp_enqueue_style( 'verticalmenu-style', get_stylesheet_uri() );
	// Load the Internet Explorer specific stylesheet.
	wp_enqueue_style( 'verticalmenu-ie', get_template_directory_uri() . '/css/ie.css', array( 'verticalmenu-style' ), '20141010' );
	wp_style_add_data( 'verticalmenu-ie', 'conditional', 'lt IE 9' );
	// Load the Internet Explorer 7 specific stylesheet.
	wp_enqueue_style( 'verticalmenu-ie7', get_template_directory_uri() . '/css/ie7.css', array( 'verticalmenu-style' ), '20141010' );
	wp_style_add_data( 'verticalmenu-ie7', 'conditional', 'lt IE 8' );
	wp_enqueue_script( 'verticalmenu-skip-link-focus-fix', get_template_directory_uri() . '/js/skip-link-focus-fix.js', array(), '20141010', true );
	if ( is_singular() && comments_open() && get_option( 'thread_comments' ) ) {
		wp_enqueue_script( 'comment-reply' );
	}
	if ( is_singular() && wp_attachment_is_image() ) {
		wp_enqueue_script( 'verticalmenu-keyboard-image-navigation', get_template_directory_uri() . '/js/keyboard-image-navigation.js', array( 'jquery' ), '20141010' );
	}
	wp_enqueue_script( 'verticalmenu-script', get_template_directory_uri() . '/js/functions.js', array( 'jquery' ), '20150330', true );
	wp_localize_script( 'verticalmenu-script', 'screenReaderText', array(
		'expand'   => '<span class="screen-reader-text">' . __( 'expand child menu', 'verticalmenu' ) . '</span>',
		'collapse' => '<span class="screen-reader-text">' . __( 'collapse child menu', 'verticalmenu' ) . '</span>',
	) );
    $verticalmenu_mobile_navigation_show = esc_attr(get_theme_mod('verticalmenu_mobile_navigation_show','yes')); 
    if($verticalmenu_mobile_navigation_show == 'yes')
    {  
        wp_enqueue_style( 'slicknav', get_template_directory_uri() . '/css/slicknav.css' );
        wp_enqueue_style( 'slicknav', get_template_directory_uri() . '/css/default.css' );
        wp_enqueue_script ( 'slickjs' , get_template_directory_uri() . '/js/jquery.slicknav.js', array( 'jquery' ), '1.0.4', false );
        wp_enqueue_script ( 'slickjsload' , get_template_directory_uri() . '/js/slicknav-load.js', array( 'jquery' ), '1.0.4', false );
    }
    wp_enqueue_script('jquery-effects-core', '', '', array('jquery'));
}
add_action( 'wp_enqueue_scripts', 'verticalmenu_scripts' );
/**
 * Add featured image as background image to post navigation elements.
 *
 * @since verticalmenu 1.0
 *
 * @see wp_add_inline_style()
 */
function verticalmenu_post_nav_background() {
	if ( ! is_single() ) {
		return;
	}
	$previous = ( is_attachment() ) ? get_post( get_post()->post_parent ) : get_adjacent_post( false, '', true );
	$next     = get_adjacent_post( false, '', false );
	$css      = '';
	if ( is_attachment() && 'attachment' == $previous->post_type ) {
		return;
	}
	if ( $previous &&  has_post_thumbnail( $previous->ID ) ) {
		$prevthumb = wp_get_attachment_image_src( get_post_thumbnail_id( $previous->ID ), 'post-thumbnail' );
		$css .= '
			.post-navigation .nav-previous { background-image: url(' . esc_url( $prevthumb[0] ) . '); }
			.post-navigation .nav-previous .post-title, .post-navigation .nav-previous a:hover .post-title, .post-navigation .nav-previous .meta-nav { color: #fff; }
			.post-navigation .nav-previous a:before { background-color: rgba(0, 0, 0, 0.4); }
		';
	}
	if ( $next && has_post_thumbnail( $next->ID ) ) {
		$nextthumb = wp_get_attachment_image_src( get_post_thumbnail_id( $next->ID ), 'post-thumbnail' );
		$css .= '
			.post-navigation .nav-next { background-image: url(' . esc_url( $nextthumb[0] ) . '); border-top: 0; }
			.post-navigation .nav-next .post-title, .post-navigation .nav-next a:hover .post-title, .post-navigation .nav-next .meta-nav { color: #fff; }
			.post-navigation .nav-next a:before { background-color: rgba(0, 0, 0, 0.4); }
		';
	}
	wp_add_inline_style( 'verticalmenu-style', $css );
}
add_action( 'wp_enqueue_scripts', 'verticalmenu_post_nav_background' );
/**
 * Navigation
 *
 * @since verticalmenu 1.0
 *
 */
    register_nav_menus( array(
		'primary' => __( 'Primary Menu',      'verticalmenu' ),
		'social'  => __( 'Social Links Menu', 'verticalmenu' ),
	) );
/**
 * Add a `screen-reader-text` class to the search form's submit button.
 *
 * @since verticalmenu 1.0
 *
 * @param string $html Search form HTML.
 * @return string Modified search form HTML.
 */
function verticalmenu_search_form_modify( $html ) {
	return str_replace( 'class="search-submit"', 'class="search-submit screen-reader-text"', $html );
}
add_filter( 'get_search_form', 'verticalmenu_search_form_modify' );
/**
 * Implement the Custom Header feature.
 *
 * @since verticalmenu 1.0
 */
require get_template_directory() . '/inc/custom-header.php';
/**
 * Custom template tags for this theme.
 *
 * @since verticalmenu 1.0
 */
require get_template_directory() . '/inc/template-tags.php';
/**
 * Customizer additions.
 *
 * @since verticalmenu 1.0
 */
/**
 * Suggest plugins.
 *
 * @since verticalmenu 1.0
 */
require_once get_template_directory() . '/inc/pinstaller.php';
require get_template_directory() . '/inc/customizer.php';
/**
 * Widgets
 *
 * @since verticalmenu 1.0
 *
 */
function verticalmenu_widget_init()
    {
    	register_sidebar( array(
    		'name'          => __( 'Sidebar Widget Area', 'verticalmenu' ),
    		'id'            => 'sidebar-1',
    		'description'   => __( 'Add widgets here to appear in your sidebar.', 'verticalmenu' ),
    		'before_widget' => '<aside id="%1$s" class="widget %2$s">',
    		'after_widget'  => '</aside>',
    		'before_title'  => '<h2 class="widget-title">',
    		'after_title'   => '</h2>',
	    ) );
        register_sidebar(array(
      		'name'          => __( 'First Footer Widget', 'verticalmenu' ),
            'id' => '1-footer',
      		'description'   => __( 'Add widgets here to appear in your left footer.', 'verticalmenu' ),
            'before_widget' => '<div>',
            'after_widget' => '</div>',
            'before_title' => '<h2>',
            'after_title' => '</h2>',
            ));
        register_sidebar(array(
      		'name'          => __( 'Second Footer Widget', 'verticalmenu' ),
            'id' => '2-footer',
      		'description'   => __( 'Add widgets here to appear in your center footer.', 'verticalmenu' ),
            'before_widget' => '<div>',
            'after_widget' => '</div>',
            'before_title' => '<h2>',
            'after_title' => '</h2>',
            ));
            register_sidebar(array(
      		'name'          => __( 'Third Footer Widget', 'verticalmenu' ),
            'id' => '3-footer',
      		'description'   => __( 'Add widgets here to appear in your right.', 'verticalmenu' ),
            'before_widget' => '<div>',
            'after_widget' => '</div>',
            'before_title' => '<h2>',
            'after_title' => '</h2>',
            ));
    }
    add_action('widgets_init', 'verticalmenu_widget_init');
/**
 * Tiny MCE Extra Buttons
 *
 * @since verticalmenu 1.0
 *
 */
if ( ! function_exists( 'verticalmenu_wp_mce_buttons' ) ) {
    function verticalmenu_wp_mce_buttons( $buttons ) {
        array_unshift( $buttons, 'fontselect' ); // Add Font Select
        array_unshift( $buttons, 'fontsizeselect' ); // Add Font Size Select
       	array_unshift( $buttons, 6,0, 'backcolor' ); 
        return $buttons;
    }
}
add_filter( 'mce_buttons_2', 'verticalmenu_wp_mce_buttons' );
/**
 * Add support to WooCommerce
 *
 * @since verticalmenu 1.0
 *
 */
add_action( 'after_setup_theme', 'verticalmenu_woocommerce_support' );
function verticalmenu_woocommerce_support() {
    add_theme_support( 'woocommerce' );
}
if ( ! function_exists( 'verticalmenu_import_files' ) ) :
 function verticalmenu_import_files() {
    $important_notice = 'Important Notes:
    <br>
    We recommend to run the Demo Import on a clean WordPress installation.
    <br>
    To reset your installation (if the import fails) we recommend <a href="https://wordpress.org/plugins/wordpress-reset/" target="_blank">WordPress Reset Plugin</a>.
    <br>
    Do not run the Demo Import multiple times, it will result in duplicated content.
    <br>
    After you import this demo, you will have to setup the slider separately.';
    return array(
        array(
            'import_file_name'           => 'Demo Import 1',
            'import_file_url'            => 'http://www.verticalmenu.eu/demo/demo-content.xml',
            'import_widget_file_url'     => 'http://www.verticalmenu.eu/demo/widgets.json',
            'import_customizer_file_url' => 'http://www.verticalmenu.eu/demo/customizer.dat',
            'import_notice'              => $important_notice,
        ),
    );
}
endif;
add_filter( 'pt-ocdi/import_files', 'verticalmenu_import_files' );
if ( ! function_exists( 'verticalmenu_after_import' ) ) :
function verticalmenu_after_import( $selected_import ) {
         //Set Menu
         $social_menu = get_term_by('name', 'social menu', 'nav_menu');
         $main_menu = get_term_by('name', 'Main Menu', 'nav_menu');
        set_theme_mod( 'nav_menu_locations' , array( 
              'primary' => $main_menu->term_id,
              'top-menu' => $main_menu->term_id,  
              'social' => $social_menu->term_id 
             ) 
        );
        // Assign front page and posts page (blog page).
        $front_page_id = get_page_by_title( 'Home' );
        $blog_page_id  = get_page_by_title( 'Blog' );
        update_option( 'show_on_front', 'page' );
        update_option( 'page_on_front', $front_page_id->ID );
        update_option( 'page_for_posts', $blog_page_id->ID );
}
add_action( 'pt-ocdi/after_import', 'verticalmenu_after_import' );
endif;
function vertical_sanitizehtml( $str ) {
    $allowed_html = array(
		'a' => array(
			'href' => true,
			'title' => true,
		),
		'abbr' => array(
			'title' => true,
		),
		'acronym' => array(
			'title' => true,
		),
		'b' => array(),
		'blockquote' => array(
			'cite' => true,
		),
		'cite' => array(),
		'code' => array(),
		'del' => array(
			'datetime' => true,
		),
		'em' => array(),
		'i' => array(),
		'q' => array(
			'cite' => true,
		),
		'strike' => array(),
		'strong' => array(),
	);
        wp_kses($str, $allowed_html); 
        return trim($str) ;
    } 
require_once( trailingslashit( get_template_directory() ) . 'trt-customize-pro/class-customize.php' );
function verticalmenu_admin_notice() {
                echo '<div class="updated"><p>';
                echo '<br />';
                echo '<img src="'.get_template_directory_uri().'/images/infox350.png" />';
                $bd_msg = '<h2>Welcome. VerticalMenu Theme was activated! </h2>';
                $bd_msg .= '<h3>For details and help, take a look at our Help Page at your left menu Appearance => Vertical Menu Help</h3>&nbsp;&nbsp;';
                $bd_url = '  <a class="button button-primary" href="'.SITEURL.'/wp-admin/themes.php?page=vertical_menu">click here</a>';
                $bd_msg .=  $bd_url;
                echo $bd_msg;
                echo "</p>";
                echo "</div>";
}
function verticalmenu_theme_was_activated() {
        add_action('admin_notices', 'verticalmenu_admin_notice');
        $bill_installed = trim(get_option( 'bill_installed',''));
        if(empty($bill_installed)){
            add_option( 'bill_installed', time() );
            update_option( 'bill_installed', time() );
        }
}
if(is_admin())
{
    add_action("after_switch_theme", "verticalmenu_theme_was_activated");
     require_once (VERTICALMENUPATH . '/inc/activated-manager.php');
    if(memory_status())
        require_once(VERTICALMENUPATH . '/inc/feedback.php');
    require_once (VERTICALMENUPATH . "/inc/feedback-last.php");
    require_once (VERTICALMENUPATH . '/inc/help.php');
    function verticalmenu_custom_dashboard_help() {
                    echo '<img src="'.get_template_directory_uri().'/images/infox350.png"  style="text-align:center; width:100%; margin: 0px 0 auto;" />';
                    echo '<a target="blank" href="http://verticalmenu.eu">';
                    echo '<img src="'.get_template_directory_uri().'/images/logo-horizontal.png" style="text-align:center; width:100%; margin: 0px 0 auto;" />';
                    echo '</a>';
                    $bd_msg = '<div style = "font-size: 14px;font-weight: bold;">';
                    $bd_msg .= '<br />For details and help, take a look at our Help Page at your left menu Appearance => Vertical Menu Help';
                    $bd_msg .= '<br /><br />';     
                    $bd_msg .= '  <a class="button button-primary" href="'.SITEURL.'/wp-admin/themes.php?page=vertical_menu">Theme Help</a>';
                    $bd_msg .= '&nbsp;&nbsp;&nbsp;';
                    $bd_url = '  <a class="button button-primary"  target="blank" href="http://verticalmenu.eu">Visit Our Site</a>';
                    $bd_msg .=  $bd_url;
                                        $bd_msg .= '&nbsp;&nbsp;&nbsp;';
                    $bd_url = '<a class="button button-primary" target="blank" href="http://verticalmenu.eu/guide/index.html">OnLine Guide</a>';
                    $bd_msg .=  $bd_url; 
                    echo $bd_msg;
                    echo "</p>";
                    echo "</div>";
    }
    function verticalmenu_add_dashboard_widgets() 
    {
         add_meta_box('verticalmenu-dashboard', 'Vertical Menu Theme Help and Support', 'verticalmenu_custom_dashboard_help', 'dashboard', 'normal', 'high');
    }
    add_action("wp_dashboard_setup", "verticalmenu_add_dashboard_widgets");
   function verticalmenu_memory_notice() {
        if(isset($_GET["tab"]))
        {
            if (strip_tags($_GET["tab"]) == 'memory')
                return;
        }
                    echo '<div class="update-nag"><p>';
                    echo '<img width="100px" src="'.get_template_directory_uri().'/images/lock.png" />';
                    $bd_msg = '<h1>Theme Vertical Menu running  in save memory mode.</h1>';
                    $bd_msg .= '<h3>To release all theme power, please, increase the WordPress memory limit.';
                   // $bd_msg .= ' For details and help, take a look at our Help Page (memory tab) at your left menu Appearance => Vertical Menu Help';
                    $bd_url = '  <a class="button button-primary" target="blank" href="'.SITEURL.'/wp-admin/themes.php?page=vertical_menu&tab=memory"> or click here</a>';
                    $bd_msg .= '<br />';
                    $bd_msg .=  $bd_url;
                    echo $bd_msg;
                    echo "</p>";
                    echo "</h3></div>";
    }
    if(! memory_status())
      add_action( 'admin_notices', 'verticalmenu_memory_notice' );
}// end If admin
if (get_site_option('verticalmenu_update_theme', '0') == '1')
  add_filter( 'auto_update_theme', '__return_true' );
function memory_status()
{
    $r = false;
    if(defined("WP_MEMORY_LIMIT"))
    {
      $wplimit =  trim(WP_MEMORY_LIMIT) ;
      $wplimit = substr($wplimit,0,strlen($wplimit)-1);
      if($wplimit >= 128)
         $r = true;
    }
    return $r; 
} 
?>