<?php get_header();
get_template_part('header', 'banner'); ?>
    <!-- Start Content -->
    <div id="content">
        <div class="container">
            <div class="row blog-post-page">
                <?php $post_layout = get_post_meta(get_the_ID(), 'post_layout', true);
				if ($post_layout == "fullwidth_left") {
                    get_sidebar();
                    $page_width = 'col-md-9';
                    $imgsize = 'matrix_blog_image';
                } elseif ($post_layout == "fullwidth") {
                    $page_width = 'col-md-12';
                    $imgsize = 'matrix_blog_image_full';
                } else{
                    $page_width = 'col-md-9';
                    $imgsize = 'matrix_blog_image';
                    $post_layout = "fullwidth_right";
                } ?>
                <div class="<?php echo esc_attr($page_width); ?> blog-box">
                    <!-- Start Single Post Area -->
                    <div class="blog-post gallery-post">
                        <?php
                        if (have_posts()) {
                            while (have_posts()) {
                                the_post();?>
                                <div class="post-head">
                                    <!--If post has gallery--><?php
                                    if (get_post_gallery()) {?>
                                        <div class="touch-slider post-slider"><?php
                                        $gallery_thumb = get_post_gallery(get_the_ID(), false);
                                        if (has_post_thumbnail()) {
                                            $img_class = array('class' => 'img-responsive');
                                            $post_thumb_id = get_post_thumbnail_id();
                                            $post_thumb_url = wp_get_attachment_image_src($post_thumb_id, true);    ?>
                                            <div class="item">
                                            <a class="lightbox" title="<?php the_title_attribute(); ?>"
                                               href="<?php echo esc_url($post_thumb_url[0]); ?>"
                                               data-lightbox-gallery="gallery1">
                                                <div class="thumb-overlay"><i class="fa fa-arrows-alt"></i></div><?php
                                                the_post_thumbnail($imgsize, $img_class); ?>
                                            </a>
                                            </div><?php
                                        }
                                        foreach ($gallery_thumb['src'] as $src_img) {
                                            ?>
                                            <div class="item">
                                            <a class="lightbox" title="<?php the_title_attribute(); ?>"
                                               href="<?php echo esc_url($src_img); ?>" data-lightbox-gallery="gallery1">
                                                <div class="thumb-overlay"><i class="fa fa-arrows-alt"></i></div>
                                                <img src="<?php echo esc_url($src_img); ?>"
                                                     alt="<?php the_title_attribute(); ?>" height="476px"/>
                                            </a>
                                            </div><?php
                                        } ?>
                                        </div><?php
                                    } elseif (has_post_thumbnail()) {
                                        $img_class = array('class' => 'img-responsive');
                                        $post_thumb_id = get_post_thumbnail_id();
                                        $post_thumb_url = wp_get_attachment_image_src($post_thumb_id, true);    ?>
                                    <a class="lightbox" title="This is an image title"
                                       href="<?php echo esc_url($post_thumb_url[0]); ?>">
                                        <div class="thumb-overlay"><i class="fa fa-arrows-alt"></i></div><?php
                                        the_post_thumbnail($imgsize, $img_class); ?>
                                        </a><?php
                                    } ?>

                                </div>
                                <!-- End Single Post (Gallery) -->

                                <!-- Start Single Post Content -->
                                <div class="post-content">
                                    <h2><?php the_title(); ?></h2>
                                    <?php matrix_entry_meta(); ?>
                                    <?php the_content(); ?>

                                    <div class="post-bottom clearfix">
                                        <?php
                                        wp_link_pages();
                                        if (get_the_tag_list() != '') {
                                            ?>
                                            <div class="post-tags-list">
                                                <i class="fa fa-tags"></i>
                                                <?php the_tags(__('Tags: ','matrix'), '  ', ''); ?>
                                            </div>
                                        <?php } ?>
                                        <?php  matrix_pagination_link(); ?>
                                    </div>

                                    <div class="author-info clearfix">
                                        <div class="author-image">
                                            <a href="<?php the_permalink(); ?>"><?php echo get_avatar(get_the_author_meta('ID'), 94); ?></a>
                                        </div>
                                        <div class="author-bio">
                                            <h4><?php the_author(); ?></h4>

                                            <p><?php the_author_meta('description'); ?></p>
                                        </div>
                                    </div>
                                </div>
                            <?php }
                        } ?>
                        <!-- End Single Post Content -->
                        
                    </div>
                    <!-- End Single Post Area -->
                    <?php comments_template('', true); ?>
                </div>
                <?php if ($post_layout == "fullwidth_right") {
                    get_sidebar();
                } ?>
            </div>
        </div>
    </div>
    <!-- End content -->
<?php get_footer(); ?>