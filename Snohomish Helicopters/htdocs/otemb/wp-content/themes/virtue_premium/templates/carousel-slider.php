 <?php 
 if ( ! defined( 'ABSPATH' ) ) {
	exit; // Exit if accessed directly
}

global $post, $virtue_premium; 
	$height = get_post_meta( $post->ID, '_kad_posthead_height', true ); 
	if (!empty($height)){
	  	$slideheight = $height;
	} else {
	  	$slideheight = 400; 
	}
	$swidth = get_post_meta( $post->ID, '_kad_posthead_width', true ); 
	if (!empty($swidth)) { 
	  	$slidewidth = $swidth; 
	} else {
	  	$slidewidth = 1140;
	}
	if(isset($virtue_premium['slider_autoplay']) && $virtue_premium['slider_autoplay'] == 0) {
	  	$autoplay = 'false';
	} else {
	  	$autoplay = 'true';
	}	
  	if(isset($virtue_premium['slider_captions'])) { 
  		$captions = $virtue_premium['slider_captions']; 
  	} else {
  		$captions = '';
  	}
   	if(isset($virtue_premium['slider_pausetime'])) {
   		$pausetime = $virtue_premium['slider_pausetime'];
	} else {
		$pausetime = '7000';
	} ?>

<section class="pagefeat carousel_outerrim">
    <div id="imageslider" class="loading">
    	<div class="carousel_slider_outer fredcarousel fadein-carousel" style="overflow:hidden; max-width:<?php echo $slidewidth;?>px; height: <?php echo $slideheight;?>px; margin-left: auto; margin-right:auto;">
       		<div class="carousel_slider initcarouselslider" data-carousel-container=".carousel_slider_outer" data-carousel-transition="600" data-carousel-height="<?php echo esc_attr($slideheight); ?>" data-carousel-auto="<?php echo esc_attr($autoplay); ?>" data-carousel-speed="<?php echo esc_attr($pausetime); ?>" data-carousel-id="pcarouselslider">
            <?php $image_gallery = get_post_meta( $post->ID, '_kad_image_gallery', true );
                  if(!empty($image_gallery)) {
                      $attachments = array_filter( explode( ',', $image_gallery ) );
                        if ($attachments) {
                          foreach ($attachments as $attachment) {
                                $attachment_url = wp_get_attachment_url($attachment , 'full');
                                $caption = get_post_field('post_excerpt', $attachment);
                                $image = aq_resize($attachment_url, null, $slideheight, false, false);
                            if(empty($image)) {$image = array($attachment_url,$slidewidth,$slideheight);} 
                            echo '<div class="carousel_gallery_item" style="float:left; display: table; position: relative; text-align: center; margin: 0; width:auto; height:'.$image[2].'px;">';
                            echo '<div class="carousel_gallery_item_inner" style="vertical-align: middle; display: table-cell;">';
                            echo '<img src="'.$image[0].'" width="'.$image[1].'" height="'.$image[2].'" />';
                              if ($captions == '1') { ?> 
                                <div class="flex-caption">
                                <?php if (!empty($caption)) echo '<div class="captiontitle headerfont">'.$caption.'</div>'; ?>
                                </div> 
                        <?php } ?>
                            </div>
                          </div>
                  <?php } } }?>
            </div>
            <div class="clearfix"></div>
             	<a id="prevport-pcarouselslider" class="prev_carousel icon-arrow-left" href="#"></a>
              	<a id="nextport-pcarouselslider" class="next_carousel icon-arrow-right" href="#"></a>
          </div> 
  </div>
</section>
            