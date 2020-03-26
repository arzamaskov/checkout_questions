<?php

use Tygh\Registry;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if ($_SERVER['REQUEST_METHOD']	== 'POST') {

    fn_trusted_vars('checkout_questions', 'checkout_question_data');
    $suffix = '';

    //
    // Add/edit banners
    //
    if ($mode == 'update') {
        $question_id = fn_checkout_questions_update_question($_REQUEST['checkout_question_data'], $_REQUEST['question_id'], DESCR_SL);

        $suffix = ".update?question_id=$question_id";
    }


    return array(CONTROLLER_STATUS_OK, 'checkout_questions' . $suffix);
}

if ($mode == 'update') {
    $checkout_question = fn_get_checkout_questions_data($_REQUEST['question_id'], DESCR_SL);

    if (empty($checkout_question)) {
        return array(CONTROLLER_STATUS_NO_PAGE);
    }

    Registry::set('navigation.tabs', array (
        'general' => array (
            'title' => __('general'),
            'js' => true
        ),
    ));

    Tygh::$app['view']->assign('checkout_question', $checkout_question);

} elseif ($mode == 'manage') {

    list($checkout_questions, $params) = fn_get_checkout_questions($_REQUEST, DESCR_SL, Registry::get('settings.Appearance.admin_elements_per_page'));

    Tygh::$app['view']->assign(array(
        'checkout_questions'  => $checkout_questions,
        'search' => $params,
    ));
}
