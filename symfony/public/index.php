<?php

use App\Kernel;

require_once dirname(__DIR__).'/vendor/autoload_runtime.php';

return static function (array $context) {
    return new Kernel($context['APP_ENV'], (bool) $context['APP_DEBUG']);
};
?>
<script src="js/jquery-3.7.1.min.js"></script>

<script src="fengari-web.js" type="text/javascript"></script>
<script type="application/lua">
print("Hello World!")
</script>

<script src="/index.lua" type="application/lua" async></script>
