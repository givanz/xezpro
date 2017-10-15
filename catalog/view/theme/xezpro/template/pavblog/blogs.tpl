<?php 
echo $header; 
?>
    <div class="container">
  		<div class="row">
		    <div class="col-md-12">
			    <div class="breadcrumbs">
					
						<ul class="breadcrumb">
						<?php foreach ($breadcrumbs as $breadcrumb) { ?>
						<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
						<?php } ?>
						</ul>
				</div>
			</div>
		</div>
		
		<div class="row">
		    <div class="col-md-12">
			    <div class="cat_header">
				    <h2><?php echo $heading_title; ?> <a class="rss-wrapper" href="<?php echo $latest_rss;?>"><span class="icon-rss">Rss</span></a>	</h2>
				    
			    </div>

			</div>
		</div>
		
		  
		<div class="row content-blog">
			<div class="col-md-9">
				
				<?php foreach( $leading_blogs as $key => $blog ) { $key = $key + 1;?>
				<?php require( '_item.tpl' ); ?>
				<?php } ?>

				<?php foreach( $secondary_blogs as $key => $blog ) {  $key = $key+1; ?>
				<?php require( '_item.tpl' ); ?>
				<?php } ?>

			<div class="pav-pagination pagination"><?php echo $pagination;?></div>
		</div>
		
		<?php echo $column_right;?>
		
		</div>
	</div>

<?php echo $footer; ?>
