<?php if($articles) { ?>
    <div class="form-group">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><?php echo $heading_title; ?></h3>
            </div>
            <div class="panel-body">
                <?php if($articles) { ?>
        	    	<?php foreach ($articles as $article) { ?>
        	    		<div class="article-author">
        	    			<a href="<?php echo $article['href']; ?>"><?php echo $article['article_title']; ?></a>
        	    		</div>
        	    		
        	    		<?php if ($article['description']) { ?>
        					<div class="description"><?php echo $article['description']; ?></div>
        				<?php } ?>
        				
        				<br />
        				<div style="border-bottom: 1px dotted #ccc;"></div>
        				<br />
        	    	<?php } ?>
        	    <?php } else { ?>
        	    	<div class="buttons">
        	    		<div class="center"><?php echo $text_no_found; ?></div>
        	    	</div>
        	    <?php } ?> 
            </div>
        </div>
    </div>
<?php } ?>