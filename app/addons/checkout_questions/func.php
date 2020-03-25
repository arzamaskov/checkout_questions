<?php

use Tygh\Registry;
use Tygh\Languages\Languages;
use Tygh\BlockManager\Block;
use Tygh\Tools\SecurityHelper;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

/**
 * Gets questions list by search params
 *
 * @param array  $params         Banner search params
 * @param string $lang_code      2 letters language code
 * @param int    $items_per_page Items per page
 *
 * @return array Banners list and Search params
 */
function fn_get_checkout_questions($params = array(), $lang_code = CART_LANGUAGE, $items_per_page = 0)
{
   
}
