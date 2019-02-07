<?php $matrix_theme_options = matrix_theme_options(); ?>
<!-- Start Services Section -->
<div class="section service">
	<div class="container">
		<div class="row">
			<!-- Start Big Heading -->
			<?php if ($matrix_theme_options['home_service_title']) { ?>
				<div class="big-title text-center" data-animation="fadeInDown" data-animation-delay="0.300">
					<h1 id="service-head"><?php echo wp_kses_post($matrix_theme_options['home_service_title']); ?></h1>
				</div>
			<?php } ?>
			<!-- End Big Heading -->
			<?php if ($matrix_theme_options['home_service_description']) { ?>
				<p id="service-desc" class="text-center" data-animation="fadeInDown" data-animation-delay="0.600"><?php echo wp_kses_post($matrix_theme_options['home_service_description']); ?></p>
			<?php
			}
			for ($i = 1; $i <= 4; $i++) {
				?>
				<!-- Start Service Icon 1 -->
				<div class="col-md-<?php echo $matrix_theme_options['home_service_column']; ?> col-sm-6 " data-animation="zoomIn"
					 data-animation-delay="0<?php echo $i; ?>">
					 <div class="<?php if($matrix_theme_options['home_service_boxed']==true){ echo 'service-boxed '; if($matrix_theme_options['home_service_hover_effect']){ echo 'hover ';} if($matrix_theme_options['home_service_shadow_effect']){ echo 'shadow ';}}else{ echo 'service-box '; } ?> service-center">
					<?php if ($matrix_theme_options['service_icon_' . $i]) {
						if ($matrix_theme_options['service_link_' . $i] != "") { ?>
						<a id="service-link-<?php echo $i; ?>" href="<?php echo esc_url($matrix_theme_options['service_link_' . $i]); ?>" target="_blank"><?php 
					} ?>
							<div id="service_box_<?php echo $i; ?>" class="service-icon">
								<i id="service-icon-<?php echo $i; ?>"
								   class="fa fa-<?php echo esc_attr($matrix_theme_options['service_icon_' . $i]); ?> icon-large"></i>
							</div>
						<?php if ($matrix_theme_options['service_link_' . $i] != "") { ?>
							</a><?php
					} }?>
					<div class="service-content"><?php if ($matrix_theme_options['service_title_' . $i] != "") {
					if ($matrix_theme_options['service_link_' . $i] != "") { ?>
					<a id="service-link-<?php echo $i; ?>" href="<?php echo esc_url($matrix_theme_options['service_link_' . $i]); ?>" target="_blank"><?php 
					} ?>
							<h4 id="service-title-<?php echo $i; ?>"><?php echo wp_kses_post($matrix_theme_options['service_title_' . $i]); ?></h4>
							<?php if ($matrix_theme_options['service_link_' . $i] != "") { ?>
							</a><?php
					} }?>
						<?php if ($matrix_theme_options['service_text_' . $i]) { ?>
							<p id="service-desc-<?php echo $i; ?>"><?php echo wp_kses_post($matrix_theme_options['service_text_' . $i]); ?></p>
						<?php } ?>
					</div>
				</div>
			</div>
				<!-- End Service Icon 1 -->
			<?php } ?>
		</div>
		<!-- .row -->
	</div>
	<!-- .container -->
</div>
<!-- End Services Section -->