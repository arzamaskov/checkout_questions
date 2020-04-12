{if $order_info.checkout_questions}

{include file="common/subheader.tpl" title=__("checkout_questions")}
    <div class="table-responsive-wrapper">
        <table class="table table-middle table--relative table-responsive">
            <thead>
                <tr>
                    <th>{__("checkout_question.title")}</th>
                    <th>{__("checkout_question.answer")}</th>
                </tr>
            </thead>
            {foreach from=$order_info.checkout_questions item=question}
                <tr>
                    <td >
                        {$question.title}
                    </td>
                    <td>
                        {if $question.value == "YesNo::YES"|enum}{__("yes")}{elseif $question.value == "YesNo::NO"|enum}{__("no")}{else}{$question.value}{/if}
                    </td>
                </tr>
            {/foreach}
        </table>
</div>
{/if}