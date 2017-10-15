<div class="box padding">
		<?php if( $blog['thumb'] && $config->get('cat_show_image') )  { ?>
		<a href="<?php echo $blog['link'];?>" title="<?php echo $blog['title'];?>"><img src="<?php echo $blog['thumb'];?>" title="<?php echo $blog['title'];?>" /></a>
		<?php } ?>

	
<?php if( $config->get('cat_show_title') ) { ?>
		<h3><a href="<?php echo $blog['link'];?>" title="<?php echo $blog['title'];?>"><?php echo $blog['title'];?></a></h3>
<?php } ?>

		<div class="post-detail">
		<?php if( $config->get('cat_show_created') ) { ?>
		<?php echo $blog['created'];?> &nbsp;<?php if( $config->get('cat_show_author') ) { ?><?php echo $this->language->get("text_write_by");?> <a href="<?php echo $blog['link'];?>"> <?php echo $blog['author'];?> </a><?php } ?>
		&nbsp;&nbsp;&nbsp;
			
		<span class="created">
			<span class="day"><?php echo date("d",strtotime($blog['created']));?></span>
			<span class="month"><?php echo date("M",strtotime($blog['created']));?></span> /
			<span class="month"><?php echo date("Y",strtotime($blog['created']));?></span>
		</span>
		<?php } ?>
		
		<?php if( $config->get('cat_show_category') ) { ?>
		<span class="publishin">
			<span><?php echo $this->language->get("text_published_in");?></span>
			<a href="<?php echo $blog['category_link'];?>" title="<?php echo $blog['category_title'];?>"><?php echo $blog['category_title'];?></a>
		</span>
		<?php } ?>
		
		<?php if( $config->get('cat_show_hits') ) { ?>
		<span class="hits"><span><?php echo $this->language->get("text_hits");?></span> <?php echo $blog['hits'];?></span>
		<?php } ?>
		<?php if( $config->get('cat_show_comment_counter') ) { ?>
		<span class="comment_count"><span><?php echo $this->language->get("text_comment_count");?></span> <?php echo $blog['comment_count'];?></span>
		<?php } ?>
		</div>
		


	<div class="text-blog clearfix">
		<?php if( $config->get('cat_show_description') ) {?>
		<div class="description">
			<?php echo $blog['description'];?>
		</div>
		<?php } ?>
		<?php if( $config->get('cat_show_readmore') ) { ?>
		<a href="<?php echo $blog['link'];?>" class="readmore"><?php echo $this->language->get('text_readmore');?></a>
		<?php } ?>
	</div>
</div>
