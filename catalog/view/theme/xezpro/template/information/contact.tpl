<?php global $opencart_version;
if (!isset($geocode)) $geocode = $address;
echo $header; ?>
<div class="container">
  <div class="row">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  </div>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>

		<div class="row">
		    <div class="col-md-12">
			    <div class="cat_header">
				    <h2><?php echo $heading_title; ?></h2>
				    <?php if (!empty($geocode)) {?>
				    <h3><?php echo $text_location; ?></h3>
				    <?php }?>
			    </div>

			</div>
		</div>

		<?php if (!empty($geocode)) {?>
		<div id="map">
			<p>Enable your JavaScript!</p>
		</div>
		<?php }?>


      <div class="panel panel-default">
        <div class="panel-body">
          <div class="row">
            <?php if (isset($image) && $image) { ?>
            <div class="col-sm-3"><img src="<?php echo $image; ?>" alt="<?php echo $store; ?>" title="<?php echo $store; ?>" /></div>
            <?php } ?>
            <div class="col-sm-3"><strong><?php echo $store; ?></strong><br />
              <address>
              <?php echo $address; ?>
              </address><!--
              <?php if (isset($geocode)) { ?>
              <a href="https://maps.google.com.hk/maps?q=<?php echo urlencode($geocode); ?>&hl=en&sll=22.352734,114.1277&sspn=1.022417,1.108246&t=h&brcurrent=3,0x0:0x0,0&z=15" target="_blank" class="btn btn-info"><i class="fa fa-map-marker"></i> <?php echo $button_map; ?></a>
              <?php } ?>-->
            </div>
            <div class="col-sm-3"><?php if ($telephone){?><strong><?php echo $text_telephone; ?></strong><br>
              <?php echo $telephone; ?><br />
              <br /><?php }?>
              <?php if ($fax) { ?>
              <strong><?php echo $text_fax; ?></strong><br>
              <?php echo $fax; ?>
              <?php } ?>
            </div>
            <div class="col-sm-3">
              <?php if (isset($open) && $open) { ?>
              <strong><?php echo $text_open; ?></strong><br />
              <?php echo $open; ?><br />
              <br />
              <?php } ?>
              <?php if (isset($comment) && $comment) { ?>
              <strong><?php echo $text_comment; ?></strong><br />
              <?php echo $comment; ?>
              <?php } ?>
            </div>
          </div>
        </div>
      </div>
      <?php if (isset($locations) && $locations) { ?>
      <h3><?php echo $text_store; ?></h3>
      <div class="panel-group" id="accordion">
        <?php foreach ($locations as $location) { ?>
        <div class="panel panel-default">
          <div class="panel-heading">
            <h4 class="panel-title"><a href="#collapse-location<?php echo $location['location_id']; ?>" class="accordion-toggle" data-toggle="collapse" data-parent="#accordion"><?php echo $location['name']; ?> <i class="fa fa-caret-down"></i></a></h4>
          </div>
          <div class="panel-collapse collapse" id="collapse-location<?php echo $location['location_id']; ?>">
            <div class="panel-body">
              <div class="row">
                <?php if ($location['image']) { ?>
                <div class="col-sm-3"><img src="<?php echo $location['image']; ?>" alt="<?php echo $location['name']; ?>" title="<?php echo $location['name']; ?>" class="img-thumbnail" /></div>
                <?php } ?>
                <div class="col-sm-3"><strong><?php echo $location['name']; ?></strong><br />
                  <address>
                  <?php echo $location['address'];?>
                  </address>
                  <?php if ($location['geocode']) { ?>
                  <a href="//maps.google.com/maps?q=<?php echo urlencode($location['geocode']); ?>&hl=<?php if (isset($geocode_hl)) echo $geocode_hl;else echo 'en'; ?>&t=m&z=15" target="_blank" class="btn btn-info"><i class="fa fa-map-marker"></i> <?php echo $button_map; ?></a>
                  <?php } ?>
                </div>
                <div class="col-sm-3"> <strong><?php echo $text_telephone; ?></strong><br>
                  <?php echo $location['telephone']; ?><br />
                  <br />
                  <?php if ($location['fax']) { ?>
                  <strong><?php echo $text_fax; ?></strong><br>
                  <?php echo $location['fax']; ?>
                  <?php } ?>
                </div>
                <div class="col-sm-3">
                  <?php if ($location['open']) { ?>
                  <strong><?php echo $text_open; ?></strong><br />
                  <?php echo $location['open']; ?><br />
                  <br />
                  <?php } ?>
                  <?php if ($location['comment']) { ?>
                  <strong><?php echo $text_comment; ?></strong><br />
                  <?php echo $location['comment']; ?>
                  <?php } ?>
                </div>
              </div>
            </div>
          </div>
        </div>
        <?php } ?>
      </div>
      <?php } ?>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
        <fieldset>
          <h3><?php echo $text_contact; ?></h3>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="form-control" />
              <?php if ($error_name) { ?>
              <div class="text-danger"><?php echo $error_name; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-email"><?php echo $entry_email; ?></label>
            <div class="col-sm-10">
              <input type="text" name="email" value="<?php echo $email; ?>" id="input-email" class="form-control" />
              <?php if ($error_email) { ?>
              <div class="text-danger"><?php echo $error_email; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-enquiry"><?php echo $entry_enquiry; ?></label>
            <div class="col-sm-10">
              <textarea name="enquiry" rows="10" id="input-enquiry" class="form-control"><?php echo $enquiry; ?></textarea>
              <?php if ($error_enquiry) { ?>
              <div class="text-danger"><?php echo $error_enquiry; ?></div>
              <?php } ?>
            </div>
          </div>
			<?php 
			if (isset($captcha)) echo $captcha; //oc 2.1.x
			else 
			if (isset($site_key) && $site_key) //oc 2.0.3
			{?> 
            <div class="form-group">
              <div class="col-sm-offset-2 col-sm-10">
                <div class="g-recaptcha" data-sitekey="<?php echo $site_key; ?>"></div>
                <?php if (isset($error_captcha) && $error_captcha) { ?>
                  <div class="text-danger"><?php echo $error_captcha; ?></div>
                <?php } ?>
              </div>
            </div>						
			<?php }	else if (isset($entry_captcha)) {// oc 2.0.1 - 1.5.6 ?>
			  <div class="form-group required">
				<label class="col-sm-2 control-label" for="input-captcha"><?php echo $entry_captcha; ?></label>
				<div class="col-sm-10">
				  <input type="text" name="captcha" value="<?php echo $captcha; ?>" id="input-captcha" class="form-control" />
				  <br/>
				  <img src="<?php if ($opencart_version >= 2000) {?>index.php?route=tool/captcha<?php } else { ?>index.php?route=information/contact/captcha<?php }?>" alt="" id="captcha" />
				  
				  <?php if (isset($error_captcha) && $error_captcha) { ?>
				  <div class="text-danger"><?php echo $error_captcha; ?></div>
				  <?php } ?>
				</div>
			  </div>
			<?php } ?>          
        </fieldset>
        <div class="buttons">
          <div class="pull-right">
            <input class="btn btn-primary" type="submit" value="<?php if (isset($button_continue)) echo $button_continue;else if (isset($button_submit)) echo $button_submit;?>" />
          </div>
        </div>
      </form>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php if (!empty($geocode)) {?>
<!--script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?v=3.exp&amp;sensor=true"></script-->
<script type="text/javascript" src="//maps.google.com/maps?file=api&v=2&key=ABQIAAAAjU0EJWnWPMv7oQ-jjS7dYxSPW5CJgpdgO_s4yyMovOaVh_KvvhSfpvagV18eOyDWu7VytS6Bi1CWxw"></script>
<script>
jQuery(window).load(function() 
{
    var map = null;
    var geocoder = null;

      if (GBrowserIsCompatible()) {
        map = new GMap2(document.getElementById("map"));
        //map.setCenter(new GLatLng(37.4419, -122.1419), 1);
        map.setUIToDefault();
        geocoder = new GClientGeocoder();
      }

      if (geocoder) {
        geocoder.getLatLng(
          '<?php echo urlencode($geocode); ?>',
          function(point) {
            if (!point) {
              alert(address + " not found");
            } else {
              map.setCenter(point, 15);
              var marker = new GMarker(point, {draggable: true});
              map.addOverlay(marker);
              GEvent.addListener(marker, "dragend", function() {
                marker.openInfoWindowHtml("<?php echo str_replace(array("\r","\n", "\r\n"), ' ', $address); ?>");
              });
              GEvent.addListener(marker, "click", function() {
                marker.openInfoWindowHtml("<?php echo str_replace(array("\r","\n", "\r\n"), ' ', $address); ?>");
              });
				GEvent.trigger(marker, "click");
            }
          }
        );
      }
});
</script>
<?php }?>
<?php echo $footer; 
