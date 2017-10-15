<div class="category_module">
		<ul>
        <?php foreach ($categories as $category) { ?>
        <li>
          <a href="<?php echo $category['href']; ?>"><?php if ($category['children']) { ?><h3><?php }?><?php echo $category['name']; ?> <?php if ($category['children']) { ?></h3><?php }?></a>

          <?php if ($category['children']) { ?>
          <ul <?php if ($category['category_id'] == $category_id) { ?>style="display:block"<?php } ?>>
            <?php foreach ($category['children'] as $child) { ?>
            <li<?php if ($child['category_id'] == $child_id) { ?> class="active"<?php } ?>>
              <a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
            </li>
            <?php } ?>
          </ul>
          <?php } ?>
        </li>
        <?php } ?>
        </ul>
</div>        
