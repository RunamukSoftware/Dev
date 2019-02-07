<?php if (!function_exists('enigma_info_page')) {
	function enigma_info_page() {
	$page1=add_theme_page(__('Welcome to Enigma', 'enigma'), __('Pro Themes & Plugin', 'enigma'), 'edit_theme_options', 'enigma', 'enigmadisplay_theme_info_page');
	
	add_action('admin_print_styles-'.$page1, 'weblizar_admin_info');
	}	
}
add_action('admin_menu', 'enigma_info_page');

function weblizar_admin_info(){
	// CSS
	wp_enqueue_style('bootstrap',  get_template_directory_uri() .'/core/admin/bootstrap/css/bootstrap.min.css');
	wp_enqueue_style('admin',  get_template_directory_uri() .'/core/admin/admin-themes.css');
	wp_enqueue_style('font-awesome',  get_template_directory_uri() .'/css/font-awesome-4.7.0/css/font-awesome.css');
	//JS
} 
if (!function_exists('enigmadisplay_theme_info_page')) {
	function enigmadisplay_theme_info_page() {
		$theme_data = wp_get_theme(); ?>
	
	
<div class="wrapper">
<!-- Header -->
<header>
<div id="snow"></div>
<div class="container-fluid p_header">
	<div class="container">
		<div class="row p_head">
		<div class="col-md-4"></div>
			<div class="col-md-4">
			<img style="width:268px;height:193px" src="<?php echo get_template_directory_uri(); ?>/images/logo.png" alt="logo">
				
			</div>
		<div class="col-md-4"></div>	
		</div>
	</div>
</div>

</header>
<!-- Header -->
<!-- Themes & Plugin -->
<div class="container-fluid space p_front theme">
	<div class="container">	
			<div class="row p_head theme">
				<div class="col-xs-12 col-md-8 col-sm-6">
					<h1 class="section-title">WordPress Themes</h1>
				</div>
			</div>
		<div class="row p_plugin blog_gallery">
			<div class="col-xs-12 col-sm-4 col-md-5 p_plugin_pic">
				<div class="img-thumbnail">
					<img src="<?php echo get_template_directory_uri(); ?>/images/Enigma.jpg" class="img-responsive" alt=""/>
				</div>
			</div>
			<div class="col-xs-12 col-sm-5 col-md-5 p_plugin_desc">
				<div class="row p-box">
					<h2><a href="">Enigma- Ultimate Multi-Purpose WordPress Theme</a></h2>
						<p><strong>Tags: </strong>clean, responsive, portfolio, blog, e-commerce, Business,
						WordPress, Corporate, dark, real estate, shop, restaurant, ele…</p>
						<div>
						<p><strong>Description: </strong>
						Enigma is a Full Responsive Multi-Purpose Theme suitable for Business , corporate office and others .Cool Blog Layout and full width page also present.</p>
						</div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-3 col-md-2 p_plugin_pic">
				<div class="price">
					<span class="currency">USD</span>
					<span class="price-number">$<span>39</span></span>
				</div>
				<div class="btn-group-vertical">
					<a class="btn btn-primary btn-lg" href="https://weblizar.com/themes/enigma-premium/">Detail</a>
					<a class="btn btn-success btn-lg" href="https://weblizar.com/themes/enigma-premium/">Buy Now</a>
				</div>			
			</div>
		</div>
		
	</div>
</div>
</div>
<?php
	}
}
?>