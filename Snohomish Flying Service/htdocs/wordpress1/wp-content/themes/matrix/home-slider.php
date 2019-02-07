<?php $matrix_theme_options = matrix_theme_options();
if (isset($matrix_theme_options['home_slider_shortcode']) && ($matrix_theme_options['home_slider_shortcode']!="" )) {
    echo do_shortcode($matrix_theme_options['home_slider_shortcode']);
}else
{ ?>
<!-- Start Home Page Slider -->
<section id="home">
    <!-- Carousel -->
    <div id="main-slide" class="carousel slide" data-ride="carousel">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <?php for ($i = 1; $i <= 3; $i++) { 
                if($matrix_theme_options['slider_img_'.$i]!=""){?>
                    <li data-target="#main-slide" data-slide-to="<?php echo $i; ?>" <?php echo $i == 1 ? 'class="active"' : ""; ?>></li>
                <?php
               }
            }
            ?>
        </ol>
        <!--/ Indicators end-->
        <!-- Carousel inner -->
        <div class="carousel-inner">
            <?php for ($i = 1; $i <= 3; $i++) { 
                if($matrix_theme_options['slider_img_'.$i]!=""){?>
                <div class="<?php echo $i == 1 ? "item active" : "item"; ?>">
                    <?php $image_id = Kirki_Helper::get_image_id( $matrix_theme_options['slider_img_'.$i] );
                    if ($image_id!=false) {
                        $img_src = wp_get_attachment_image_url($image_id, 'matrix_slider_post',false);
                    }else{
                        $img_src =$matrix_theme_options['slider_img_'.$i];
                    }?>
                    <img src="<?php echo esc_url($img_src); ?>" class="matrix_slider_post img-responsive">
                    <div class="slider-content">
                        <div class="col-md-12 text-center">
                            <?php if($matrix_theme_options['slider_title_'.$i]!=""){?>
                            <h2 class="animated2"><span id="slide-title-<?php echo $i; ?>"><?php    echo wp_kses_post($matrix_theme_options['slider_title_'.$i]);?></span></h2>
                            <?php } ?>

                            <?php if($matrix_theme_options['slider_subtitle_'.$i]!=""){?>
                            <h3 class="animated3">
                                <span id="slide-subtitle-<?php echo $i; ?>"><?php echo wp_kses_post($matrix_theme_options['slider_subtitle_'.$i]); ?></span>
                            </h3>
                            <?php } ?>
                            <?php 
                            $link='';
                            if (isset($matrix_theme_options['slider_post_page_' . $i]) && $matrix_theme_options['slider_post_page_' . $i] == 'post') {
                                    if (isset($matrix_theme_options['post_slider_' . $i]) && $matrix_theme_options['post_slider_' . $i] != 0) {$link = get_permalink($matrix_theme_options['post_slider_' . $i]);}
                                } else {
                                    if (isset($matrix_theme_options['page_slider_' . $i]) && $matrix_theme_options['page_slider_' . $i] != 0) {$link = get_permalink($matrix_theme_options['page_slider_' . $i]);}
                                }
                                if($link!='' && isset($matrix_theme_options['slider_readmore_' . $i]) && $matrix_theme_options['slider_readmore_' . $i]!=''){?>
                            <a id="slide<?php echo $i; ?>-btn1" class="animated4 slider slider-btn1 btn btn-primary btn-min-block" href="<?php echo esc_url($link); ?>"><?php if(isset($matrix_theme_options['slider_readmore_' . $i]) && $matrix_theme_options['slider_readmore_' . $i]!=''){ echo esc_attr($matrix_theme_options['slider_readmore_' . $i]); }?></a>
                            <?php } ?>
                        </div>
                    </div>
                </div>
                <?php }
                } ?>
        </div>
        <!-- Carousel inner end-->
        <!-- Controls -->
        <?php if($matrix_theme_options['slider_img_1']!="" && $matrix_theme_options['slider_img_2']!=""){ ?>
            <a class="left carousel-control" href="#main-slide" data-slide="prev">
                <span><i class="fa fa-angle-left"></i></span>
            </a>
            <a class="right carousel-control" href="#main-slide" data-slide="next">
                <span><i class="fa fa-angle-right"></i></span>
            </a>
        <?php } ?>
    </div>
    <!-- /carousel -->
</section>
<!-- End Home Page Slider -->
    <?php } ?>