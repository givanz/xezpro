<div class="panel panel-default">
  <div class="panel-body" style="text-align: right;">
    <span id="pp_login_container"></span>
    <script src="https://www.paypalobjects.com/js/external/api.js"></script>
    <script>
    paypal.use( ["login"], function(login) {
      login.render ({
		'appid': '<?php if (isset($pp_login_client_id)) echo $pp_login_client_id;else echo client_id; ?>',
		'authend': '<?php if (isset($pp_login_sandbox)) echo $pp_login_sandbox;else echo sandbox; ?>',
		'scopes': '<?php if (isset($pp_login_scopes)) echo $pp_login_scopes;else echo scopes; ?>',
		'containerid': 'pp_login_container',
		'locale': '<?php if (isset($pp_login_locale)) echo $pp_login_locale;else echo locale; ?>',
		'theme': '<?php if (isset($pp_login_button_colour)) echo $pp_login_button_colour;else echo button_colour; ?>',
		'returnurl': '<?php if (isset($pp_login_return_url)) echo $pp_login_return_url;else echo return_url; ?>'
      });
    });
    </script>
  </div>
</div>
