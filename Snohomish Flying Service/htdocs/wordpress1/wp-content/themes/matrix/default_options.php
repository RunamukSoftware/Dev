<?php
function matrix_theme_options(){	
	$banner_img = get_template_directory_uri() . '/images/banner.jpg';
    $matrix_theme_options = array(
        //General Settings
        '_frontpage' => 'on',
        'matrix_custom_css' => '',
        /* Layout */
        'site_layout' => 'wide',
        'logo_layout' => 'left',
        'footer_layout' => 3,
        'headersticky' => 0,
        'color_scheme' => 'red',
        //Slide
		'home_slider_posts' => '',
        'slider_img_1'=>get_template_directory_uri().'/images/slide.jpg',
        'slider_img_2'=>get_template_directory_uri().'/images/slide.jpg',
        'slider_img_3'=>get_template_directory_uri().'/images/slide.jpg',

        'slider_title_1'=>__('Welcome To <strong>Matrix</strong>','matrix'),
        'slider_subtitle_1'=>__('The ultimate aim of your business','matrix'),

        'slider_title_2'=>__('<strong>Matrix</strong> For The Highest','matrix'),
        'slider_subtitle_2'=>__('The Key Of Your Success','matrix'),

        'slider_title_3'=>__('Why Are You <strong>Waitting</strong>','matrix'),
        'slider_subtitle_3'=>__('Download and Start Customizing Your Site','matrix'),
        
        'home_slider_shortcode'=>'',
        // service
        'home_service_boxed'=>0,
        'home_service_hover_effect'=>0,
        'home_service_shadow_effect'=>0,
        'home_service_title' => __('Our <span>Services</span>', 'matrix'),
        'home_service_description' => __('Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.', 'matrix'),
        'home_service_column' => 3,
        'service_title_1' => __("Creative Ideas", 'matrix'),
        'service_icon_1' => "rocket",
        'service_text_1' => __("There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in.", 'matrix'),
		'service_link_1' => "#",

        'service_title_2' => __("Records", 'matrix'),
        'service_icon_2' => "database",
        'service_text_2' => __("There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in.", 'matrix'),
		'service_link_2' => "#",

        'service_title_3' => __("WordPress", 'matrix'),
        'service_icon_3' => "wordpress",
        'service_text_3' => __("There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in.", 'matrix'),
		'service_link_3' => "#",

        'service_title_4' => __('Fully Responsive', 'matrix'),
        'service_icon_4' => "mobile",
        'service_text_4' => __('There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in', 'matrix'),
		'service_link_4' => "#",
        //portfolio
        'home_portfolio_title'=>__('Our <span>Portfolio</span>','matrix'),
        'home_portfolio_description'=>__('Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium. ','matrix'),
        'portfolio_four_column' => 1,
		'portfolio_shortcode'=>'',
        'portfolio_gallery'=>'',
		//Extra Settings:
		'home_extra_title' => __('Extra Content', 'matrix'),
		'home_extra_description' => __('Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.', 'matrix'),
		'extra_content_home' => '',
        // call out area settings
        'callout_bg_image' => $banner_img,
		'callout_external_bg_video'=>esc_url('https://www.youtube.com/watch?v=jnLSYfObARA'),
        'home_callout_description' => __('MATRIX Theme IS READY FOR BUSINESS, AGENCY OR CREATIVE PORTFOLIOS', 'matrix'),
        'anim_texts' => __('MODERN,CLEAN,AWESOME,GREAT,COOL', 'matrix'),
        'home_callout_btn_1' => __('Check Out Features', 'matrix'),
        'home_callout_btn_2' => __('Purchase This Now', 'matrix'),
        'home_callout_btn1_link' => '#',
        'home_callout_btn2_link' => '#',
        'home_callout_btn1_icon' => 'cloud-download',
        'home_callout_btn2_icon' => 'shopping-cart',
        // Home Blog Settings
        'home_blog_title' => __('Our Latest <span>Posts</span>' , 'matrix'),
        'home_blog_description' => __('Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.', 'matrix'),
		'home_post_cat' => '',
        'show_load_more_btn'=>1,
        'home_post_num'=>3,
        'home_load_post_num'=>3,
        'blog_no_more_post'       => __('No older posts found', 'matrix'),
        'blog_more_loading'       => __('Loading', 'matrix'),
        'blog_load_more_text'     => __('Load More', 'matrix'),
        /** Social media links **/
        'social_media_header' => 'on',
        'social_media_footer' => 'on',
        'header_shocial_media_bar' => 'on',
        'contact_info_header' => 'on',
        'social_twitter_link' => 'http://twitter.com/',
        'social_facebook_link' => 'http://facebook.com',
        'social_google_plus_link' => 'http://www.google.com',
        'social_linkedin_link' => 'http://liknkedin.com/',
        'social_dribble_link' => 'http://dribble.com/',
        'social_instagram_link' => 'http://instagram.com/',
        'contact_address' => __('1-A-16, Lorem Ipsum, India', 'matrix'),
        'contact_email' => 'webhuntinfotech@gmail.com',
        'contact_phone' => '+99999999',
        /** footer customization **/
        'copyright_text_footer' => 'on',
		'show_footer_widget' => 'on',
        'footer_copyright_text' => __('Theme Developed By ', 'matrix'),
        'created_by_matrix_text' => __('WebHunt Infotech', 'matrix'),
        'created_by_link' => 'http://www.webhuntinfotech.com/',
		'home_sections' => array('slider', 'service', 'portfolio', 'blog', 'callout', 'content'),
    );
    return wp_parse_args(get_option('matrix_theme_options', array()), $matrix_theme_options);
}
?>