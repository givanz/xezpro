	<div class="col-md-12">
	<div class="heading title clearfix"><h2><?php echo $heading_title; ?></h2></div>
	<div class="box-content row" >
		<?php if( !empty($blogs) ) { ?>
		<div class="pavblog-latest clearfix">
			<?php foreach( $blogs as $key => $blog ) { $key = $key + 1;?>
			<div class="col-md-<?php echo round(12/$cols);?> col-sm-<?php echo round(12/$cols);?>">
					<div class="blog-item">
							<div class="blog-header clearfix">
							<h4 class="blog-title">
								<a href="<?php echo $blog['link'];?>" title="<?php echo $blog['title'];?>"><?php echo $blog['title'];?></a>
							</h4>
							</div>
							<div class="blog-body">
								<?php if( $blog['thumb']  )  { ?>
								<img src="<?php echo $blog['thumb'];?>" title="<?php echo $blog['title'];?>" alt="<?php echo $blog['title'];?>"/>
								<?php } ?>
								<div class="description">
										<?php echo utf8_substr( $blog['description'],0, 100 );?>...
								</div>
								<a href="<?php echo $blog['link'];?>" class="readmore"><?php echo $this->language->get('text_readmore');?></a>
							</div>	
						</div>
			</div>
			<?php if( ( $key%$cols==0 || $key == count($blogs)) ){  ?>
				<div class="clearfix"></div>
			<?php } ?>
			<?php } ?>
		</div>
		<?php } ?>
	</div>
 </div>