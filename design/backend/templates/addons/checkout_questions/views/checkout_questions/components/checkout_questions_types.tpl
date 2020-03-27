{$selectbox = "ProductOptionTypes::SELECTBOX"|enum}
{$radio_group = "ProductOptionTypes::RADIO_GROUP"|enum}
{$checkbox = "ProductOptionTypes::CHECKBOX"|enum}
{$input = "ProductOptionTypes::INPUT"|enum}
{$text = "ProductOptionTypes::TEXT"|enum}

{strip}
{if $display == "view"}
    {if $value == $selectbox}{__("selectbox")}
    {elseif $value == $checkbox}{__("checkbox")}
    {elseif $value == $input}{__("text")}
    {elseif $value == $text}{__("textarea")}
    {/if}
{else}

    {if $value}
	{if $value == $selectbox}
	    {$app_types = "{$selectbox}"}
	{elseif $value == $input || $value == $text}
	    {$app_types = "{$input}{$text}"}
	{elseif $value == $checkbox}
	    {$app_types = "{$checkbox}"}
	{/if}
    {else}
	{$app_types = ""}
    {/if}
    
    <select class="cm-option-type-selector" data-ca-option-inventory-selector="#elm_inventory_{$id}" id="{$tag_id}" name="{$name}" {if $check}onchange="fn_check_option_type(this.value, this.id);"{/if}>
	{if !$app_types || ($app_types && $app_types|strpos:$selectbox !== false)}
	    <option value="{$selectbox}" {if $value == $selectbox} selected="selected"{/if}>{__("selectbox")}</option>
	{/if}
	{if !$app_types || ($app_types && $app_types|strpos:$checkbox !== false)}
	    <option value="{$checkbox}" {if $value == $checkbox} selected="selected"{/if}>{__("checkbox")}</option>
	{/if}
	{if !$app_types || ($app_types && $app_types|strpos:$input !== false)}
	    <option value="{$input}" {if $value == $input} selected="selected"{/if}>{__("text")}</option>
	{/if}
	{if !$app_types || ($app_types && $app_types|strpos:$text !== false)}
	    <option value="{$text}" {if $value == $text} selected="selected"{/if}>{__("textarea")}</option>
	{/if}
    </select>

{/if}
{/strip}
