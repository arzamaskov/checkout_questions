{if $in_popup}
    <div class="adv-search">
    <div class="group">
{else}
    <div class="sidebar-row">
    <h6>{__("search")}</h6>
{/if}

<form name="checkout_questions_search_form" action="{""|fn_url}" method="get" class="{$form_meta}">

    {if $smarty.request.redirect_url}
        <input type="hidden" name="redirect_url" value="{$smarty.request.redirect_url}" />
    {/if}

    {if $selected_section != ""}
        <input type="hidden" id="selected_section" name="selected_section" value="{$selected_section}" />
    {/if}

    {if $put_request_vars}
        {array_to_fields data=$smarty.request skip=["callback"]}
    {/if}

    {$extra nofilter}

    {capture name="simple_search"}
        <div class="sidebar-field">
            <label for="elm_title">{__("checkout_questions")}</label>
            <div class="break">
                <input type="text" name="title" id="elm_title" value="{$search.title}" />
            </div>
        </div>

        <div class="sidebar-field">
            <label for="elm_type">{__("type")}</label>
            <div class="controls">
                <select name="type" id="elm_type">
                    <option value="">{__("all")}</option>
                    <option {if $search.type == "S"}selected="selected"{/if} value="S">{__("checkout_question_selectbox")}</option>
                    <option {if $search.type == "C"}selected="selected"{/if} value="C">{__("checkout_question_checkbox")}</option>
                    <option {if $search.type == "I"}selected="selected"{/if} value="I">{__("checkout_question_input")}</option>
                    <option {if $search.type == "T"}selected="selected"{/if} value="T">{__("checkout_question_text")}</option>
                </select>
            </div>
        </div>

        <div class="sidebar-field">
            <label for="elm_type">{__("status")}</label>
            {assign var="items_status" value=""|fn_get_default_statuses:true}
            <div class="controls">
                <select name="status" id="elm_type">
                    <option value="">{__("all")}</option>
                    {foreach from=$items_status key=key item=status}
                        <option value="{$key}" {if $search.status == $key}selected="selected"{/if}>{$status}</option>
                    {/foreach}
                </select>
            </div>
        </div>
    {/capture}

    {include file="common/advanced_search.tpl" no_adv_link=true simple_search=$smarty.capture.simple_search dispatch=$dispatch view_type="checkout_questions"}

</form>

{if $in_popup}
    </div></div>
{else}
    </div><hr>
{/if}