<?php if($comments) { ?>
    <?php foreach ($comments as $comment) { ?>
		<div class="article-reply form-group">
  			<div class="author"><b><?php echo $comment['author']; ?></b></div>
  			<div class="comment-date"> <?php echo $comment['date_added']; ?></div>
  
  			<div class="text"><?php echo $comment['comment']; ?></div><br />
  			
  			<div><a onclick="setArticleId(<?php echo $comment['simple_blog_comment_id']; ?>);" style="cursor: pointer;"><?php echo $text_reply_comment; ?></a></div>
  			<br />
  			<?php if($comment['comment_reply']) { ?>
  				<?php foreach($comment['comment_reply'] as $comment_reply) { ?>
	  				<div class="article-reply">
			  			<div class="author"><b><?php echo ucwords($comment_reply['author']); ?></b></div>
			  			<div class="comment-date"><?php echo $comment_reply['date_added'];  ?></div>
			  			<div class="text"><?php echo $comment_reply['comment']; ?></div>
					</div>
				<?php } ?>
  			<?php } ?>
  			
		</div>
	<?php } ?>
    
    <div class="form-group">
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 text-left"><?php echo $pagination; ?></div>
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 text-right"><?php echo $results; ?></div>
    </div>
        
<?php } else { ?>
    <h5><?php echo $text_no_blog; ?></h5>
<?php } ?>

<script type="text/javascript">
	function setArticleId(article_id) {
		$("#blog-reply-id").val(article_id);
		$("#reply-remove").css('display', 'inline');
	}
</script>