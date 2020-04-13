<?php

use Tygh\Registry;

$cart = &Tygh::$app['session']['cart'];

if ($mode == 'place_order') {
    if(isset($cart['checkout_questions_data'])) {
        unset($cart['checkout_questions_data']);
    }
    $data = $_REQUEST['checkout_questions_data'];
    $checkout_questions_data = array();
    $lang_code = CART_LANGUAGE;
    
    foreach ($data as $key => $value) {
        $checkout_questions_data[$key]['title'] = db_get_field("SELECT title FROM ?:checkout_question_descriptions WHERE question_id = ?i AND ?:checkout_question_descriptions.lang_code = ?s", $key, $lang_code);
        $checkout_questions_data[$key]['value'] = $value;
    }

    Tygh::$app['session']['cart']['checkout_questions_data'][] = $checkout_questions_data;
}
