{script src="js/tygh/tabs.js"}
{literal}
    <script type="text/javascript">
    function fn_check_option_type(value, tag_id)
    {
        var id = tag_id.replace('checkout_question_type_', '').replace('elm_', '');
        Tygh.$('#tab_option_variants_' + id).toggleBy(!(value == 'S' || value == 'R' || value == 'C'));
        Tygh.$('#required_options_' + id).toggleBy(!(value == 'I' || value == 'T' || value == 'F'));
        Tygh.$('#extra_options_' + id).toggleBy(!(value == 'I' || value == 'T'));
        Tygh.$('#file_options_' + id).toggleBy(!(value == 'F'));

        if (value == 'C') {
            var t = Tygh.$('table', '#content_tab_option_variants_' + id);
            Tygh.$('.cm-non-cb', t).switchAvailability(true); // hide obsolete columns
            Tygh.$('tbody:gt(1)', t).switchAvailability(true); // hide obsolete rows

        } else if (value == 'S' || value == 'R') {
            var t = Tygh.$('table', '#content_tab_option_variants_' + id);
            Tygh.$('.cm-non-cb', t).switchAvailability(false); // show all columns
            Tygh.$('tbody', t).switchAvailability(false); // show all rows
            Tygh.$('#box_add_variant_' + id).show(); // show "add new variants" box

        } else if (value == 'I' || value == 'T') {
            Tygh.$('#extra_options_' + id).show(); // show "add new variants" box
        }
    }
    </script>
{/literal}

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

<div class="tabs cm-j-tabs">
    <ul class="nav nav-tabs">
        <li id="tab_option_details_{$id}" class="cm-js active"><a>{__("general")}</a></li>
        {if $checkout_question.type == "ProductOptionTypes::SELECTBOX"|enum
            || $checkout_question.type == "ProductOptionTypes::RADIO_GROUP"|enum
            || $checkout_question.type == "ProductOptionTypes::CHECKBOX"|enum
            || !$checkout_question
        }
            <li id="tab_option_variants_{$id}" class="cm-js"><a>{__("variants")}</a></li>
        {/if}
    </ul>
</div>

<div class="cm-tabs-content" id="tabs_content_{$id}">
    <div id="content_tab_option_details_{$id}">
    <fieldset>
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
            <label class="control-label" for="elm_checkout_question_type_{$id}">{__("type")}</label>
            <div class="controls">
            {include file="addons/checkout_questions/views/checkout_questions/components/checkout_questions_types.tpl"  name="checkout_question_data[type]" value=$checkout_question.type display="select" tag_id="elm_checkout_question_type_`$id`" check=true}
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

    </fieldset>
    <!--content_tab_option_variants_{$id}--></div>
    <div class="hidden" id="content_tab_option_variants_{$id}">
        <fieldset>
            <div class="table-responsive-wrapper">
                <table class="table table-middle table--relative table-responsive">
                    <thead>
                        <tr class="first-sibling">
                            <th class="cm-non-cb">{__("position_short")}</th>
                            <th>{__("variant")}</th>
                        </tr>
                    </thead>
                    <tbody>
                    {foreach from=$checkout_question.variants item="vr" name="fe_v"}
                    {assign var="num" value=$smarty.foreach.fe_v.iteration}
                    <tbody class="hover cm-row-item" id="option_variants_{$id}_{$num}">
                        <tr>
                            <td class="cm-non-cb" data-th="{__("position_short")}">
                                <input type="text" name="checkout_question_data[variants][{$num}][position]" value="{$vr.position}" size="3" class="input-micro" />
                            </td>
                            <td  data-th="{__("variant")}">
                                <input type="text" name="checkout_question_data[variants][{$num}][variant]" value="{$vr.variant}" />
                            </td>
                            <td class="nowrap">
                                <input type="hidden" name="checkout_question_data[variants][{$num}][variant_id]" value="{$vr.variant_id}" class="{$cm_no_hide_input}" />
                            </td>
                        </tr>
                    </tbody>
                    {/foreach}
                    {math equation="x + 1" assign="num" x=$num|default:0}{assign var="vr" value=""}
                    <tbody class="hover cm-row-item" id="box_add_variant_{$id}">
                        <tr>
                            <td class="cm-non-cb" data-th="{__("position")}">
                                <input type="text" name="checkout_question_data[variants][{$num}][position]" value="" size="3" class="input-micro" /></td>
                            <td data-th="{__("name")}">
                                <input type="text" name="checkout_question_data[variants][{$num}][variant]" value="" /></td>
                            <td class="right cm-non-cb{if $checkout_question.type == "ProductOptionTypes::CHECKBOX"|enum} hidden{/if}">
                                {include file="buttons/multiple_buttons.tpl" item_id="add_variant_`$id`" tag_level="2"}
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </fieldset>
    <!--content_tab_option_variants_{$id}--></div>
</div>

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

<script type="text/javascript">
 (function (_, $) {
     var support_inventory_type = [
	 '{"ProductOptionTypes::SELECTBOX"|enum}',
	 '{"ProductOptionTypes::RADIO_GROUP"|enum}',
	 '{"ProductOptionTypes::CHECKBOX"|enum}'
     ];
     $.ceEvent('on', 'ce.commoninit', function (context) {
         var $self = $('.cm-option-type-selector', context);
	 var $parent = $($self.data('caOptionInventorySelector'));
	 if ($self.length) {
	     $self.on('change', function(){
		 var value = $self.val();
		 if (support_inventory_type.indexOf(value) !== -1) {
		     $parent.prop("disabled", false);
		 } else {
		     $parent.prop("disabled", true);
		     $parent.prop("checked", false);
		 }
	     });
	     $self.trigger('change');
	 }});
 }(Tygh, Tygh.$));
</script>


{** checkout questions section **}