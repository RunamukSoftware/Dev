<?php $matrix_theme_options = matrix_theme_options();
 if($matrix_theme_options['portfolio_shortcode']!=""){
      echo do_shortcode($matrix_theme_options['portfolio_shortcode']);
}else{?>
<!-- Start Portfolio Section -->
<div class="section full-width-portfolio" style="border-top:0; border-bottom:0; background:#fff;">
	<!-- Start Big Heading -->
	<?php if($matrix_theme_options['home_portfolio_title']!=""){?>
	<div class="big-title text-center" data-animation="fadeInDown" data-animation-delay="01">
		<h1 id="portfolio-head"><?php echo wp_kses_post($matrix_theme_options['home_portfolio_title']); ?></h1>
	</div><?php 
	} ?>
	<!-- End Big Heading -->
	<?php if($matrix_theme_options['home_portfolio_description']!=""){ ?>
	<p id="portfolio-desc" class="text-center" data-animation="fadeInDown" data-animation-delay="02"><?php echo wp_kses_post($matrix_theme_options['home_portfolio_description']); ?></p>
	<?php }
		if($matrix_theme_options['portfolio_gallery']!=""){ ?>
		<!-- Start Recent Projects Carousel -->
		<ul id="portfolio-list" data-animated="fadeIn">
		<?php $i=1;
		$gallery = explode(',', $matrix_theme_options['portfolio_gallery']);
		foreach ($gallery as $image) {
		$img_attr = matrix_get_attachment($image); ?>
		<li data-animation="zoomIn" data-animation-delay="0.<?php echo (int)$i; ?>">
			<div class="portfolio-item-content">
				<span class="header"><?php echo esc_attr($img_attr['alt']); ?></span>
				<p class="body"><?php echo esc_attr($img_attr['caption']); ?></p>
			</div>
			<a class="lightbox" data-lightbox-gallery="gallery1" href="<?php echo esc_attr($img_attr['src']);?>"><i class="fa fa-search-plus more"></i><img src="<?php echo esc_attr($img_attr['src']);?>" alt="<?php echo esc_attr($img_attr['alt']); ?>" class="img-responsive port_img match-height"></a>
		</li>
		<?php $i++;
		}
		?>
		</ul><?php 
		} ?>
		<!-- End Recent Projects Carousel -->
</div>
<!-- End Portfolio Section -->
<?php } ?>