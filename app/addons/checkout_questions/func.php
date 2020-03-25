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
    // Set default values to input params
    $default_params = array(
        'page' => 1,
        'items_per_page' => $items_per_page
    );

    $params = array_merge($default_params, $params);

    if (AREA == 'C') {
        $params['status'] = 'A';
    }

    $sortings = array(
        'position' => '?:checkout_questions.position',
        'timestamp' => '?:checkout_questions.timestamp',
        'title' => '?:checkout_question_descriptions.title',
        'type' => '?:checkout_questions.type',
        'status' => '?:checkout_questions.status',
    );

    $condition = $limit = $join = '';

    if (!empty($params['limit'])) {
        $limit = db_quote(' LIMIT 0, ?i', $params['limit']);
    }

    $sorting = db_sort($params, $sortings, 'title', 'asc');

    $condition .= fn_get_localizations_condition('?:checkout_questions.localization');
    $condition .= (AREA == 'A') ? '' : db_quote(' AND (?:checkout_questions.type != ?s)', 'S');

    if (!empty($params['item_ids'])) {
        $condition .= db_quote(' AND ?:checkout_questions.question_id IN (?n)', explode(',', $params['item_ids']));
    }

    if (!empty($params['title'])) {
        $condition .= db_quote(' AND ?:checkout_question_descriptions.title LIKE ?l', '%' . trim($params['title']) . '%');
    }

    if (!empty($params['type'])) {
        $condition .= db_quote(' AND ?:checkout_questions.type = ?s', $params['type']);
    }

    if (!empty($params['status'])) {
        $condition .= db_quote(' AND ?:checkout_questions.status = ?s', $params['status']);
    }

    if (!empty($params['period']) && $params['period'] != 'A') {
        list($params['time_from'], $params['time_to']) = fn_create_periods($params);
        $condition .= db_quote(' AND (?:checkout_questions.timestamp >= ?i AND ?:checkout_questions.timestamp <= ?i)', $params['time_from'], $params['time_to']);
    }

    $fields = array (
        '?:checkout_questions.question_id',
        '?:checkout_questions.type',
        '?:checkout_questions.status',
        '?:checkout_questions.position',
        '?:checkout_question_descriptions.title',
        '?:checkout_questions.required'
    );

    $join .= db_quote(' LEFT JOIN ?:checkout_question_descriptions ON ?:checkout_question_descriptions.question_id = ?:checkout_questions.question_id AND ?:checkout_question_descriptions.lang_code = ?s', $lang_code);

    if (!empty($params['items_per_page'])) {
        $params['total_items'] = db_get_field("SELECT COUNT(*) FROM ?:checkout_questions $join WHERE 1 $condition");
        $limit = db_paginate($params['page'], $params['items_per_page'], $params['total_items']);
    }

    $questions = db_get_hash_array(
        "SELECT ?p FROM ?:checkout_questions " .
        $join .
        "WHERE 1 ?p ?p ?p",
        'question_id', implode(', ', $fields), $condition, $sorting, $limit
    );

    if (!empty($params['item_ids'])) {
        $questions = fn_sort_by_ids($questions, explode(',', $params['item_ids']), 'question_id');
    }   

    return array($questions, $params);
}
