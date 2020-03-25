<?php

use Tygh\Registry;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if ($mode == 'manage') {
    $data = 2;

    Tygh::$app['view']->assign('all_data', $data);
}
