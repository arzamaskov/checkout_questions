{if $order_info.checkout_questions_data}
<div>
    <h3>{__("checkout_questions")}</h3>
    <div class="table-responsive-wrapper">
        <table class="ty-orders-summary__table">
            {foreach from=$order_info.checkout_questions_data item=questions_list}
                {foreach from=$questions_list item=question}
                    <tr class="ty-orders-summary__row">
                        <td>{$question.title}:</td>
                        <td>{if $question.value == "YesNo::YES"|enum}{__("yes")}{elseif $question.value == "YesNo::NO"|enum}{__("no")}{else}{$question.value}{/if}</td>
                    </tr>
                {/foreach}
            {/foreach}
        </table>
    </div>
</div>
{/if}