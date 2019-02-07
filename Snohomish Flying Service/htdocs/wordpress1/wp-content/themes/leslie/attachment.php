<?php
/*
 * attachment.php
 * The template to show images/attachments.
 * @theme Leslie
 */ 
get_header(); ?>
    <div class="c4">
    
        <div id="nav-bar" role="navigation">
            <nav class="main-nav">
                <?php wp_nav_menu( array( 'container_id' => 'access', 'theme_location' => 'primary' ) ); ?>
            </nav><!-- ends access# -->
        </div>
            
    </div><!-- ends c4 -->
        <div class="c8" role="main">
            
            <div id="content">
                <?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
                    <div class="photometa">
                        <?php
                        $metadata = wp_get_attachment_metadata();
                        printf( __( 'Published&#058; <span class="entry-date"><time class="datelink" datetime="%1$s" pubdate>%2$s</time></span> | Orig&#39; Resolution&#058;  <a href="%3$s" title="Link to full-size image">%4$s &times; %5$s</a> <br> Gallery&#058; <a href="%6$s" title="Return to %7$s" rel="gallery">%7$s</a>', 'leslie' ),
                        esc_attr( get_the_date( 'c' ) ),
                        esc_html( get_the_date() ),
                        wp_get_attachment_url(),
                        $metadata['width'],
                        $metadata['height'],
                        get_permalink( $post->post_parent ),
                        get_the_title( $post->post_parent )
                        ); ?>
                    </div><!-- .entry-meta -->
                        <div class="entry-attachment">
                            <div class="attachment">
                            <?php
/* Grab the IDs of all the image attachments in a gallery so we can get the URL of the next adjacent image in a gallery,
 * or the first image (if we're looking at the last ), or, in a gallery of one, just the link to that image file
 */
                                $attachments = array_values( get_children( array( 
                                'post_parent' => $post->post_parent, 
                                'post_status' => 'inherit', 
                                'post_type' => 'attachment', 
                                'post_mime_type' => 'image', 
                                'order' => 'ASC', 
                                'orderby' => 'menu_order ID' 
                                ) ) );
                                    foreach ( $attachments as $k => $attachment ) {
                                        if ( $attachment->ID == $post->ID )
                                            break;
                                    }
                                $k++;
                                // If there is more than 1 attachment in a gallery
                                    if ( count( $attachments ) > 1 ) {
                                        if ( isset( $attachments[ $k ] ) )
                                        // get the URL of the next image attachment
                                        $next_attachment_url = get_attachment_link( $attachments[ $k ]->ID );
                                            else
                                            // or get the URL of the first image attachment
                                            $next_attachment_url = get_attachment_link( $attachments[ 0 ]->ID );
                                            } else {
                                            // or, if there's only 1 image, get the URL of the image
                                            $next_attachment_url = wp_get_attachment_url();
                                    } ?>
                                    <a href="<?php echo $next_attachment_url; ?>" title="<?php echo esc_attr( get_the_title() ); ?>" rel="attachment">
                                    <?php $attachment_size = apply_filters( 'leslie_attachment_size', array( 1200, 1200 ) );
                                    // Filterable image size.
                                    echo wp_get_attachment_image( $post->ID, $attachment_size ); ?></a>
                            </div><!-- .attachment -->
 
                              <?php if ( ! empty( $post->post_excerpt ) ) : ?>
                                    <div class="entry-caption">
                                        <?php the_excerpt(); ?>
                                    </div><!-- .entry-caption -->
                                    <?php endif; ?>
                        </div><!-- .entry-attachment -->
                                <?php comments_template(); ?>

                <?php endwhile; ?>
       
                    <?php else : ?>
                    <?php get_template_part( 'content', 'none' ); ?>
            
                <?php endif; ?>
                
            <div><!-- ends content -->
            
        </div><!-- ends c8 -->
    </section>
        <?php get_footer(); ?>