{if $checkout_question}
    {assign var="id" value=$checkout_question.question_id}
{else}
    {assign var="id" value=0}
{/if}

{** checkout question section **}

{$allow_save = $question|fn_allow_save_object:"questions"}
{$hide_inputs = ""|fn_check_form_permissions}
{assign var="b_type" value=$checkout_question.type|default:""}

{capture name="mainbox"}

<form action="{""|fn_url}" method="post" class="form-horizontal form-edit{if !$allow_save || $hide_inputs} cm-hide-inputs{/if}" name="checkout_questions_form" enctype="multipart/form-data">
<input type="hidden" class="cm-no-hide-input" name="fake" value="1" />
<input type="hidden" class="cm-no-hide-input" name="question_id" value="{$id}" />

{capture name="tabsbox"}

    <div id="content_general">
        <div class="control-group">
            <label for="elm_checkout_question_position" class="control-label">{__("position_short")}</label>
            <div class="controls">
                <input type="text" name="checkout_question_data[position]" id="elm_checkout_question_position" value="{$checkout_question.position|default:"0"}" size="3"/>
            </div>
        </div>

        <div class="control-group">
            <label for="elm_checkout_question_title" class="control-label cm-required">{__("checkout_question.title")}</label>
            <div class="controls">
            <input type="text" name="checkout_question_data[title]" id="elm_checkout_question_title" value="{$checkout_question.title}" size="25" class="input-large" /></div>
        </div>

        <div class="control-group">
            <label for="elm_checkout_question_type" class="control-label cm-required">{__("type")}</label>
            <div class="controls">
            <select name="checkout_question_data[type]" id="elm_checkout_question_type" onchange="Tygh.$('#checkout_question_graphic').toggle();  Tygh.$('#checkout_question_text').toggle(); Tygh.$('#checkout_question_url').toggle();  Tygh.$('#checkout_question_target').toggle();">
                <option {if $checkout_question.type == "S"}selected="selected"{/if} value="S">{__("checkout_question_selectbox")}</option>
                <option {if $checkout_question.type == "R"}selected="selected"{/if} value="R">{__("checkout_question_radio")}</option>
                <option {if $checkout_question.type == "C"}selected="selected"{/if} value="C">{__("checkout_question_checkbox")}</option>
                <option {if $checkout_question.type == "I"}selected="selected"{/if} value="I">{__("checkout_question_input")}</option>
                <option {if $checkout_question.type == "T"}selected="selected"{/if} value="T">{__("checkout_question_text")}</option>
            </select>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="elm_checkout_question_required">{__("required")}</label>
            <div class="controls">
            <input type="hidden" name="checkout_question_data[required]" value="N" />
            <input type="checkbox" name="checkout_question_data[required]" id="elm_checkout_question_required" value="Y" {if $checkout_question.required == "Y"}checked="checked"{/if} />
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="elm_checkout_question_timestamp_{$id}">{__("creation_date")}</label>
            <div class="controls">
            {include file="common/calendar.tpl" date_id="elm_checkout_question_timestamp_`$id`" date_name="checkout_question_data[timestamp]" date_val=$checkout_question.timestamp|default:$smarty.const.TIME start_year=$settings.Company.company_start_year}
            </div>
        </div>

        {include file="views/localizations/components/select.tpl" data_name="checkout_question_data[localization]" data_from=$checkout_question.localization}

        {include file="common/select_status.tpl" input_name="checkout_question_data[status]" id="elm_checkout_question_status" obj_id=$id obj=$checkout_question hidden=true}

        <div id="content_addons" class="hidden clearfix"></div>

{/capture}

{include file="common/tabsbox.tpl" content=$smarty.capture.tabsbox active_tab=$smarty.request.selected_section track=true}

{capture name="buttons"}
    {if !$id}
        {include file="buttons/save_cancel.tpl" but_role="submit-link" but_target_form="checkout_questions_form" but_name="dispatch[checkout_questions.update]"}
    {else}
        {if "ULTIMATE"|fn_allowed_for && !$allow_save}
            {assign var="hide_first_button" value=true}
            {assign var="hide_second_button" value=true}
        {/if}
        {include file="buttons/save_cancel.tpl" but_name="dispatch[checkout_questions.update]" but_role="submit-link" but_target_form="checkout_questions_form" hide_first_button=$hide_first_button hide_second_button=$hide_second_button save=$id}
    {/if}
{/capture}

</form>

{/capture}

{notes}
    {__("checkout_question_details_notes", ["[layouts_href]" => fn_url('block_manager.manage')])}
{/notes}

{if !$id}
    {$title = __("checkout_questions.new_question")}
{else}
    {$title_start = __("checkout_questions.editing_question")}
    {$title_end = $checkout_question.title}
{/if}

{include file="common/mainbox.tpl"
    title_start=$title_start
    title_end=$title_end
    title=$title
    content=$smarty.capture.mainbox
    buttons=$smarty.capture.buttons
    select_languages=true}

{** banner section **}