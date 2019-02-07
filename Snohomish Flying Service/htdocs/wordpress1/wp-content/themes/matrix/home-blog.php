<?php $matrix_theme_options = matrix_theme_options(); ?>
<!-- Start Testimonials Section -->
<div id="home-blog" class="section service">
    <div class="container">
        <div class="row">
            <!-- Start Big Heading -->
            <?php if ($matrix_theme_options['home_blog_title']) { ?>
                <div class="big-title text-center" data-animation="fadeInDown" data-animation-delay="01">
                    <h1 id="blog-heading"><?php echo wp_kses_post($matrix_theme_options['home_blog_title']); ?></h1>
                </div>
            <?php } ?>
            <!-- End Big Heading -->
            <?php if ($matrix_theme_options['home_blog_description']) { ?>
                <p class="text-center"
                   id="blog-desc"><?php echo wp_kses_post($matrix_theme_options['home_blog_description']); ?></p>
            <?php } ?>
            <div class="col-md-12">
                <!-- Start Recent Posts Carousel -->
                <div class="latest-posts">
                    <h4 class="classic-title"><span></span></h4>

                    <div class="latest-posts-classic grid ajax_posts">
                        <div class="hero-grid__grid-sizer"></div><?php
						if(isset($matrix_theme_options['home_post_cat'])){
						  $cat = $matrix_theme_options['home_post_cat'];
						}
                        $i=1;
						$args = array('post_type' => 'post', 'category__in'=>$cat,'posts_per_page'=>$matrix_theme_options['home_post_num']);
						query_posts($args);
                        if (query_posts($args)) {
                            while (have_posts()):the_post(); ?>
                                <!-- Posts  -->
                                <div class="post-row grid-item " data-animation="zoomIn" data-animation-delay="0.<?php echo (int)$i; ?>">
                                    <?php
                                    if (has_post_thumbnail()):
                                        $img_class = array('class' => 'img-responsive full-width'); ?>
                                        <div class="blog_img">
                                            <?php the_post_thumbnail('matrix_home_post_image', $img_class); ?>
                                        </div>
                                    <?php endif; ?>
                                    <h3 class="post-title"><a href="<?php the_permalink(); ?>"><?php the_title(); ?></a></h3>
                                    <span class="post-meta"><i class="fa fa-clock-o"></i> <a href="<?php the_permalink(); ?>"><?php echo esc_attr(get_the_date(get_option('date_format'), get_the_ID())); ?></a>
                                    <i class="fa fa-comments-o"></i> <?php esc_url(comments_popup_link(__('No Comments', 'matrix'), __('1 Comment', 'matrix'), __('% Comments', 'matrix'))); ?></span>
                                    <div class="post-content">
										<?php the_excerpt(); ?>
									</div>
                                </div>
                            <?php $i++; endwhile;
                        } ?>

                    </div>
                </div>
                <!-- End Recent Posts Carousel -->
            </div>
        </div>
    </div><?php if($matrix_theme_options['show_load_more_btn']){?>
    <div class="matrix_carousel-navi home-blog-content">
        <button id="more_posts" type="submit" class="tiny btn btn-default loadmore button" data-loading-text="<i class='fa fa-circle-o-notch fa-spin'></i> <?php echo esc_attr($matrix_theme_options['blog_more_loading']);?>"><?php echo esc_attr($matrix_theme_options['blog_load_more_text']); ?></button>
    </div><?php 
} ?>
</div>