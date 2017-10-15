<div class="box pavblogs-comments-box">
	<div class="box-heading"><?php echo $heading_title; ?></div>
	<div class="box-content" >
		<?php if( !empty($comments) ) { ?>
		<div class="pavblog-comments clearfix">
			 <?php $default=''; foreach( $comments as $comment ) { ?>
				<div class="pav-comment clearfix">
					<a href="<?php echo $comment['link'];?>" title="<?php echo $comment['user'];?>">
					<img src="<?php echo "http://www.gravatar.com/avatar/" . md5( strtolower( trim( $comment['email'] ) ) ) . "?d=" . urlencode( $default ) . "&s=60" ?>" align="left" alt=""/>
					</a>
					<div class="comment"><?php echo utf8_substr( $comment['comment'], 50 ); ?></div>
					<span class="comment-author"><?php echo $this->language->get('text_postedby');?> <?php echo $comment['user'];?>...</span>
				</div>
			 <?php } ?>
		</div>
		<?php } ?>
	</div>
 </div>
