<!--cols:<?php if (isset($grid_cols) && $grid_cols) echo $grid_cols + $grid_offset;else echo 12;?>   -->
<?php $cols = 'col-xs-' . $cols_xs . ' col-sm-' . $cols_sm . ' col-md-' . $cols_md . ' col-lg-' . $cols_lg;?>
<div class="<?php if (isset($grid_cols) &&$grid_cols) {?>col-md-<?php echo $grid_cols;}?> <?php if (isset($grid_offset) && $grid_offset) {?>col-md-offset-<?php echo $grid_offset;}?> <?php if (isset($grid_padding) && $grid_padding) {?>no_padding<?php if (isset($grid_padding) && $grid_padding == 2) echo 'left';else if (isset($grid_padding) && $grid_padding == 3) echo 'right'; }?>">
	<div class="heading title clearfix"><h2><?php if (isset($title)) echo $title; ?></h2></div>
	<div class="box-content row" >
		<?php if( !empty($blogs) ) { ?>
		<div class="clearfix">
			<?php foreach( $blogs as $key => $blog ) {?>
			<div class="<?php echo $cols?>">
					<div class="blog-item">
							
							<div class="blog-header clearfix">
							<h4 class="blog-title">
								<a href="<?php echo $blog['href'];?>" title="<?php echo $blog['name'];?>"><?php echo $blog['name'];?></a>
							</h4>
							</div>
							
							<div class="blog-body">
								<?php if(isset($blog['thumb']) && $blog['thumb'])  { ?>
								<img src="<?php echo $blog['thumb'];?>" title="<?php echo $blog['name'];?>" alt="<?php echo $blog['name'];?>"/>
								<?php } ?>
								
								<div class="description">
										<?php echo utf8_substr( strip_tags($blog['intro_text'], '<img>'),0, 150 );?>...
								</div>
								<a href="<?php echo $blog['href'];?>" class="readmore"><?php echo $text_readmore;?></a>
							</div>	
					</div>
			</div>
			<?php } ?>
		</div>
		<?php } ?>
	</div>
 </div>
