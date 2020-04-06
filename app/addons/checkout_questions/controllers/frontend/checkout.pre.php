<?php

use Tygh\Registry;

$cart = &Tygh::$app['session']['cart'];

if ($mode == 'place_order') {
    if(isset($cart['checkout_questions_data'])) {
        unset($cart['checkout_questions_data']);
    }
    $checkout_questions_data = $_REQUEST['checkout_questions_data'];
        Tygh::$app['session']['cart']['checkout_questions_data'][] = $checkout_questions_data;

}
