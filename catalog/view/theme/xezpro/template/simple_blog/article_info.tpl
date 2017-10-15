<?php echo $header; ?>
    <div class="container">
        <ul class="breadcrumb">
            <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
            <?php } ?>
        </ul>
        
        <div class="form-group">
            <?php echo $column_left; ?>
            <?php if ($column_left && $column_right) { ?>
                <?php $class = 'col-sm-6'; ?>
            <?php } elseif ($column_left || $column_right) { ?>
                <?php $class = 'col-sm-9'; ?>
            <?php } else { ?>
                <?php $class = 'col-sm-12'; ?>
            <?php } ?>
            
            <div id="content" class="<?php echo $class; ?>">
                <?php echo $content_top; ?>
                
                <div class="row form-group">
                    <?php if(isset($article_info_found)) { ?>
                        <div class="article-info">
    						<div class="article-title">
    							<h1><?php echo $article_info['article_title']; ?><h1>
    						</div>
                            
                            <div class="article-sub-title">
    							<span class="article-author"><a href="<?php echo $author_url; ?>"><?php echo $article_info['author_name']; ?></a></span>
    							
    							<span class="bullet">&bull;</span>
    							<span class="article-date"><?php echo $article_date_modified; ?></span>
    							
    							<?php if($article_info['allow_comment']) { ?>
    								<span class="bullet">&bull;</span>
    								<span class="article-comment"><?php echo $total_comment; ?></span>
    							<?php } ?>	
    							
    							<?php if((isset($simple_blog_share_social_site)) && ($simple_blog_share_social_site)) { ?>
    								<span class="article-share" style="float: right;">
    								
    									<span class="addthis_default_style"><a class="addthis_button_facebook"></a> <a class="addthis_button_twitter"></a> <a class="addthis_button_google_plusone_share"></a> <a class="addthis_button_linkedin"></a> <a class="addthis_button_pinterest_share"></a></span>
              							<script type="text/javascript" src="//s7.addthis.com/js/250/addthis_widget.js"></script> 
    								
    								
    									<!-- ShareThis Button BEGIN -->
    									<!-- <script type="text/javascript" src="http://w.sharethis.com/button/buttons.js"></script>
    									<script type="text/javascript">stLight.options({publisher: "ur-d825282d-618f-598d-fca6-d67ef9e76731", doNotHash: true, doNotCopy: true, hashAddressBar: false});</script>
    									<span class='st_facebook' displayText=''></span>
    									<span class='st_twitter' displayText=''></span>
    									<span class='st_linkedin' displayText=''></span>
    									<span class='st_googleplus' displayText=''></span>
    									<span class='st_pinterest' displayText=''></span> -->
    									<!-- ShareThis Button END -->
    								</span>
    							<?php } ?>					
    						</div>
                            
                            <?php if($image) { ?>
    							<?php if(isset($featured_found)) { ?>
    								<div class="article-image">
    									<img src="<?php echo $image; ?>" alt="<?php echo $article_info['article_title']; ?>" height="500" />
    								</div>
    							<?php } else { ?>
    								<div class="article-thumbnail-image">
    									<img src="<?php echo $image; ?>" alt="<?php echo $article_info['article_title']; ?>" height="100" width="100" />
    									<span class="article-description">
    										<?php echo html_entity_decode($article_info['description'], ENT_QUOTES, 'UTF-8'); ?>
    									</span>
    								</div>
    							<?php } ?>
    						<?php } ?>
                            
                            <?php if(isset($featured_found)) { ?>
    							<div class="article-description">
    								<?php echo html_entity_decode($article_info['description'], ENT_QUOTES, 'UTF-8'); ?>
    							</div>
    						<?php } else { ?>
    							<div class="article-description">
    								<?php echo html_entity_decode($article_info['description'], ENT_QUOTES, 'UTF-8'); ?>
    							</div>
    						<?php } ?>
                            
                            <?php if($article_additional_description) { ?>
    							<?php foreach($article_additional_description as $description) { ?>
    								<div class="article-description">
    									<?php echo html_entity_decode($description['additional_description'], ENT_QUOTES, 'UTF-8'); ?>
    								</div>
    							<?php } ?>
    						<?php } ?>
                            
                            <?php if($products) { ?>
                                <div class="panel">
                                    <div class="panel-heading">
                                        <h3 class="panel-title"><?php echo $text_related_product; ?></h3>
                                    </div>
                                    <div class="panel-body">
                                        <div class="row product-layout">
                                            <?php foreach($products as $product) { ?>
                                                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                                                    <div class="product-thumb transition simple-blog-product">
                                                    
                                                        <?php if ($product['thumb']) { ?>
        								        			<div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
        								        		<?php } ?>  
                                                        
                                                        <div class="caption text-center">
                                                            <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>  
                                                        </div>
                                                    </div>    
                                                </div>
                                            <?php } ?>
                                        </div>
                                    </div>
                                </div>
                            <?php } ?>
                            
                            <?php if((isset($simple_blog_related_articles)) && $simple_blog_related_articles && ($related_articles)) { ?>
                                <div class="panel">
                                    <div class="panel-heading">
                                        <h3 class="panel-title"><?php echo $text_related_article; ?></h3>
                                    </div>
                                    
                                    <div class="panel-body">
                                        <div class="related-article">
                                        	<div class="row form-group">
                                        		<?php foreach($related_articles as $related_article) { ?>		
                                        			<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                        				<div class="form-group">
                                                            <div class="name text-center">
                                                                <a href="<?php echo $related_article['article_href']; ?>"><?php echo $related_article['article_title']; ?></a>
                                                            </div>
                                                            
                                                            <div class="related-article-meta">
                                            					<?php echo $text_posted_by; ?> <a href="<?php echo $related_article['author_href']; ?>"><?php echo $related_article['author_name']; ?></a> | <?php echo $text_on; ?> <?php echo $related_article['date_added']; ?> | <?php echo $text_updated; ?> <?php echo $related_article['date_modified']; ?> |
                                            				</div>
                                                            
                                                            <div class="image text-center">
                                                                <a href="<?php echo $related_article['article_href']; ?>">
																	<img src="<?php echo $related_article['image']; ?>" alt="<?php echo $related_article['article_title']; ?>" title="<?php echo $related_article['article_title']; ?>" class="img-responsive img-thumbnail" />
																</a>
                                                            </div>
                                                            
                                                            <div>
                                                                <?php if($column_left || $column_right) { ?>
                                        							<?php echo utf8_substr(strip_tags(html_entity_decode($related_article['description'], ENT_QUOTES, 'UTF-8')), 0, 100) . '...'; ?>
                                        						<?php } else { ?>
                                        							<?php echo utf8_substr(strip_tags(html_entity_decode($related_article['description'], ENT_QUOTES, 'UTF-8')), 0, 350) . '...'; ?>
                                        						<?php } ?>
                                                            </div>
                                                            
                                                            <div class="related-article-button">
                                            					<a href="<?php echo $url; ?>" class="btn btn-success"><?php echo $button_continue_reading; ?></a>
                                            				</div>
                                                            
                                                            <div class="related-article-footer">
                                            					<?php echo $related_article['total_comment']; ?><?php echo $text_comment_on_article; ?> <a href="<?php echo $related_article['article_href']; ?>#comment-section"><?php echo $text_view_comment; ?></a>
                                            				</div>
                                                            
                                                        </div>
                                        			</div>
                                        		<?php } ?>
                                        	</div>
                                        </div>

                                    </div>
                                        
                                </div>
                            <?php } ?>
                            
                            
                            <?php if(isset($simple_blog_author_information) && $simple_blog_author_information) { ?>
                                <?php if(isset($author_image)) { ?>
                                    <div class="panel">
                                        <div class="panel-heading">
                                            <h3 class="panel-title"><?php echo $author_name . " " . $text_author_information; ?></h3>
                                        </div>
                                        
                                        <div class="panel-body">
                                            <div class="author-info">
    											<div class="col-lg-2 col-md-2 col-sm-3 col-xs-12">
    												<img src="<?php echo $author_image; ?>" alt="<?php echo $article_info['article_title']; ?>" style="border: 1px solid #cccccc; padding: 5px; border-radius: 5px;" />
    											</div>
    											<div class="col-lg-10 col-md-10 col-sm-9 col-xs-12">
    												<?php echo $author_description; ?>
    											</div>
    										</div>
                                        </div>
                                    </div>
                                <?php } ?>
                            <?php } ?>
                            
                            <?php if($article_info['allow_comment']) { ?>
                                
                                <div class="panel">
                                    <div class="panel-heading">
                                        <h3 class="panel-title"><?php echo $text_related_comment; ?></h3>
                                    </div>
                                    
                                    <div class="panel-body">
                                        <div class="form-group">
                                            <div id="comments" class="blog-comment-info">
        										<div id="comment-list"></div>
        										<div id="comment-section"></div>
        										<h2 id="review-title">
        											<?php echo $text_write_comment; ?>
        											<i class="fa fa-times-circle fa-lg" id="reply-remove" style="display:none; cursor: pointer;" onclick="removeCommentId();"></i>
        										</h2>							
        										<input type="hidden" name="blog_article_reply_id" value="0" id="blog-reply-id"/>
        										
        										<div class="comment-left">
        											<b><?php echo $entry_name; ?></b><br />
        											<input type="text" name="name" value="" class="form-control" /><br />
        											<b><?php echo $entry_review; ?></b><br />
        										    <textarea name="text" class="form-control"></textarea>
        										    <span style="font-size: 11px;"><?php echo $text_note; ?></span>
        										    <br /><br />
        										    <b><?php echo $entry_captcha; ?></b><br />
        										    <input type="text" name="captcha" style="" value="" class="form-control" /><br />
        										    <div class="form-group">
                                                        <div class="col-sm-12"> <img src="index.php?route=tool/captcha" alt="" id="captcha" /> </div>
                                                    </div>
        										</div>
        										<br />
        										<div class="text-right"><a id="button-comment" class="btn btn-info"><span><?php echo $button_submit; ?></span></a></div>			
                                            </div>    										
    									</div>
                                    </div>                                    
                                </div>                                    
                            <?php } ?>
                            
                        </div>
                    <?php } else { ?>
                        <h3 class="text-center"><?php echo $text_no_found; ?></h3>
                    <?php } ?>
                </div>
                
                <?php echo $content_bottom; ?>
            </div>
            
            <?php echo $column_right; ?>
        </div>        
    </div>
    
    <script type="text/javascript">
		function removeCommentId() {
			$("#blog-reply-id").val(0);
			$("#reply-remove").css('display', 'none');
		}
	</script>
    
    <script type="text/javascript">
		$('#comment-list .pagination a').delegate('click', function() {
			$('#comment-list').fadeOut('slow');
				
			$('#comment-list').load(this.href);
			
			$('#comment-list').fadeIn('slow');
			
			return false;
		});			
		
		$('#comment-list').load('index.php?route=simple_blog/article/comment&simple_blog_article_id=<?php echo $simple_blog_article_id; ?>');
		
	</script>	
    
    <script type="text/javascript">		
			$('#button-comment').bind('click', function() {
				$.ajax({
					type: 'POST',
					url: 'index.php?route=simple_blog/article/writeComment&simple_blog_article_id=<?php echo $simple_blog_article_id; ?>',
					dataType: 'json',
					data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()) + '&reply_id=' + encodeURIComponent($('input[name=\'blog_article_reply_id\']').val()),
					beforeSend: function() {
						$('.success, .warning').remove();
						$('#button-comment').attr('disabled', true);
						$('#review-title').after('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
					},
					complete: function() {
						$('#button-comment').attr('disabled', false);
						$('.attention').remove();
					},
					success: function(data) {
					   
                        $('.alert').remove();
                        
						if (data['error']) {
							$('#review-title').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + data['error'] + '</div>');
						}
						
						if (data['success']) {
							$('#review-title').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + data['success'] + '</div>');
											
							$('input[name=\'name\']').val('');
							$('textarea[name=\'text\']').val('');
							$('input[name=\'captcha\']').val('');
							$("#blog-reply-id").val(0);
							$("#reply-remove").css('display', 'none');
							
							$('#comment-list').load('index.php?route=simple_blog/article/comment&simple_blog_article_id=<?php echo $simple_blog_article_id; ?>');							
						}
					}
				});
			});
		</script> 	
		
    
<?php echo $footer; ?>
