<?php /**
 * The template for displaying the footer
 *
 * Contains the closing of the "site-content" div and all content after.
 *
 * @package verticalmenu
 * 
 * @since verticalmenu 1.0
 */ ?>
   <footer id="colophon" class="site-footer"> <!-- role="contentinfo"> -->
   <div class="footer-container">
   <div class="footer-column column-one">
       	<?php if (is_active_sidebar('1-footer')): ?>
			<div id="widget-area1" class="widget-area" role="complementary">
				<?php dynamic_sidebar('1-footer'); ?>
			</div><!-- .widget-area -->
		<?php endif; ?>
   </div>
   <div class="footer-column column-two">
      	<?php if (is_active_sidebar('2-footer')): ?>
			<div id="widget-area2" class="widget-area" role="complementary">
				<?php dynamic_sidebar('2-footer'); ?>
			</div><!-- .widget-area -->
		<?php endif; ?>
   </div>
   <div class="footer-column column-three">
      	<?php if (is_active_sidebar('3-footer')): ?>
			<div id="widget-area3" class="widget-area" role="complementary">
				<?php dynamic_sidebar('3-footer'); ?>
			</div><!-- .widget-area -->
		<?php endif; ?>
   </div>
   </div>   
	</footer><!-- .site-footer -->
	   <div class="site-info">
			<?php /**
 * Fires before the verticalmenu footer text for footer customization.
 *
 * @since verticalmenu 1.0
 */
$verticalmenu_footer_copyright = trim(get_theme_mod('verticalmenu_footer_copyright'));
if (!empty($verticalmenu_footer_copyright)) {
    echo  vertical_sanitizehtml($verticalmenu_footer_copyright);
} else {
    echo esc_html('Powered by verticalmenu.eu');
} ?>
        	</div><!-- .site-info -->  
       	</div><!-- .site-content --> 
</div><!-- .site -->
</div> <!-- wrapper -->
<?php wp_footer(); ?> 
<div class="back-to-top-row">       
<a href="#" class="back-to-top">Back to Top</a>
</div> 
</body>
</html>