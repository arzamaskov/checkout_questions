{** checkout questions section **}

{capture name="mainbox"}

<form action="{""|fn_url}" method="post" name="checkout_questions_form" class="cm-hide-inputs" enctype="multipart/form-data">
    <input type="hidden" name="fake" value="1" />
    {include file="common/pagination.tpl" save_current_page=true save_current_url=true
    div_id="pagination_contents_checkout_questions"}

    {assign var="c_url" value=$config.current_url|fn_query_remove:"sort_by":"sort_order"}

    {assign var="rev" value=$smarty.request.content_id|default:"pagination_contents_checkout_questions"}
    {assign var="c_icon" value="<i class=\"icon-`$search.sort_order_rev`\"></i>"}
    {assign var="c_dummy" value="<i class=\"icon-dummy\"></i>"}

     {if $checkout_questions}
     <div class="table-responsive-wrapper">
        <table class="table table-middle table--relative table-responsive">
            <thead>
                <tr>
                    <th width="1%" class="left mobile-hide">
                        {include file="common/check_items.tpl" class="cm-no-hide-input"}
                    </th>
    
                    <th width="6%" class="nowrap">
                        <a class="cm-ajax" href="{"`$c_url`&sort_by=position&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("position_short")}{if $search.sort_by == "position"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
                    </th>

                    <th>
                        <a class="cm-ajax" href="{"`$c_url`&sort_by=title&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("checkout_question.title")}{if $search.sort_by == "title"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
                    </th>

                    <th class="mobile-hide">
                        <a class="cm-ajax" href="{"`$c_url`&sort_by=type&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("type")}{if $search.sort_by == "type"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
                    </th>

                    <th>
                        <a class="cm-ajax" href="{"`$c_url`&sort_by=required&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("required")}{if $search.sort_by == "required"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
                    </th>

                    <th width="6%" class="mobile-hide">&nbsp;</th>
                    <th width="10%" class="right">
                        <a class="cm-ajax" href="{"`$c_url`&sort_by=status&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("status")}{if $search.sort_by == "status"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
                    </th>
                </tr>
            </thead>
            {foreach from=$checkout_questions item=checkout_question}
            <tr class="cm-row-status-{$checkout_question.status|lower}">
                {assign var="allow_save" value=$checkout_question|fn_allow_save_object:"checkout_questions"}

                {if $allow_save}
                {assign var="no_hide_input" value="cm-no-hide-input"}
                {else}
                {assign var="no_hide_input" value=""}
                {/if}

                <td class="left mobile-hide">
                    <input type="checkbox" name="checkout_question_ids[]" value="{$checkout_question.question_id}" class="cm-item {$no_hide_input}" />
                </td>

                <td class="left" data-th="{__("position_short")}">
                    <input type="text" name="checkout_question_postiton[{$checkout_question.question_id}][position]" value="{$checkout_question.position}" size="3" class="input-micro input-hidden" />
                </td>

                <td class="{$no_hide_input}" data-th="{__("checkout_question")}">
                    <a class="row-status" href="{" checkout_questions.update?question_id=`$checkout_question.question_id`"|fn_url}">{$checkout_question.title}</a>
                </td>

                <td class="nowrap row-status {$no_hide_input} mobile-hide">
                    {if $checkout_question.type == ""}{__("checkout_question.type_other")}{else}{__("checkout_question.type")}{/if}
                </td>

                <td class="nowrap row-status {$no_hide_input} mobile-hide">
                    {if $checkout_question.required == "N"}{__("checkout_question.no_required")}{else}{__("checkout_question.required")}{/if}
                </td>

                <td class="mobile-hide">
                    {capture name="tools_list"}
                    <li>{btn type="list" text=__("edit") href="checkout_questions.update?question_id=`$checkout_question.question_id`"}</li>
                    {if $allow_save}
                    <li>{btn type="list" class="cm-confirm" text=__("delete")
                        href="checkout_questions.delete?question_id=`$checkout_question.question_id`" method="POST"}</li>
                    {/if}
                    {/capture}
                    <div class="hidden-tools">
                        {dropdown content=$smarty.capture.tools_list}
                    </div>
                </td>
                <td class="right" data-th="{__(" status")}">
                    {include file="common/select_popup.tpl" id=$checkout_question.question_id status=$checkout_question.status hidden=true
                    object_id_name="question_id" table="checkout_questions" popup_additional_class="`$no_hide_input` dropleft"}
                </td>
            </tr>
            {/foreach}
        </table>
    </div>
    {else}
    <p class="no-items">{__("no_data")}</p>
    {/if}

    {include file="common/pagination.tpl" div_id="pagination_contents_checkout_questions"}

    {capture name="buttons"}
    {capture name="tools_list"}
    {if $checkout_questions}
    <li>{btn type="delete_selected" dispatch="dispatch[checkout_questions.m_delete]" form="checkout_questions_form"}</li>
    {/if}
    {/capture}
    {dropdown content=$smarty.capture.tools_list class="mobile-hide"}
    {/capture}
    {capture name="adv_buttons"}
    {include file="common/tools.tpl" tool_href="checkout_questions.add" prefix="top" hide_tools="true" title=__("add_checkout_question")
    icon="icon-plus"}
    {/capture}

</form>

{/capture}

{capture name="sidebar"}
{include file="common/saved_search.tpl" dispatch="checkout_questions.manage" view_type="checkout_questions"}
{include file="addons/checkout_questions/views/checkout_questions/components/checkout_questions_search_form.tpl" dispatch="checkout_questions.manage"}
{/capture}

{$page_title = __("checkout_questions.page_title")}
{$select_languages = true}

{include file="common/mainbox.tpl" title=$page_title content=$smarty.capture.mainbox buttons=$smarty.capture.buttons
adv_buttons=$smarty.capture.adv_buttons select_languages=$select_languages sidebar=$smarty.capture.sidebar}

{** ad section **}