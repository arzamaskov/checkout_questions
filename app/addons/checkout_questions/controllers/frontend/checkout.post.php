<?php 

use Tygh\Registry;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if ($mode == 'checkout') {

    list($checkout_questions, $params) = fn_get_checkout_questions($_REQUEST, DESCR_SL, Registry::get('settings.Appearance.admin_elements_per_page'));

    Tygh::$app['view']->assign(array(
        'checkout_questions'  => $checkout_questions
    ));
}
