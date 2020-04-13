{if $checkout_questions}

{if $cart.checkout_questions_data}
{foreach from=$cart.checkout_questions_data item=answer}
    <div class="litecheckout__container">
        <div class="litecheckout__container">
            <!-- title -->
            <div class="litecheckout__group">
                <div class="litecheckout__item ">
                    <h2 class="litecheckout__step-title">{$block_title|default:__("checkout_questions")}</h2>
                </div>
            </div>
            <!-- title -->
            
            <!-- questions block -->
            {foreach from=$checkout_questions item="question"}
            <div class="cm-processing-personal-data" data-ca-processing-personal-data-without-click="true">
                <div class="litecheckout__group">
                    <div class="litecheckout__group">
                    <!-- selectbox block -->
                    {if $question.type == "ProductOptionTypes::SELECTBOX"|enum}
                        <div class="litecheckout__item">
                            <label class="litecheckout__item {if $question.required == "YesNo::YES"|enum}cm-required{/if}" for="question_{$question.question_id}">{$question.title}:</label>
                        </div>
                        <div class="litecheckout__field cm-field-container litecheckout__field--small ">
                            <select class="litecheckout__input litecheckout__input--selectable "
                                    id="question_{$question.question_id}"
                                    data-ca-lite-checkout-field="{$field_name_helper}"
                                    data-ca-lite-checkout-auto-save-on-change="true"
                                    aria-label="{$question.title}"
                                    title="{$question.title}"
                                    name="checkout_questions_data[{$question.question_id}]"
                            >
                                {if $question.required == "YesNo::NO"|enum}
                                    <option value="">--</option>
                                {/if}
                                {foreach from=$question.variants item="variant"}
                                    <option {if {$answer.{$question.question_id}.value} == $variant.variant}selected{/if} value="{$variant.variant}">{$variant.variant}</option>
                                {/foreach}
                            </select>
                            
                        </div>
                    <!-- selectbox block -->
                    <!-- checkbox block -->
                    {elseif $question.type == "ProductOptionTypes::CHECKBOX"|enum}
                    <div class="litecheckout__group">
                        <div class="litecheckout__item" style="width: 100%;">
                            <div class="ty-profile-field__switch ty-address-switch clearfix litecheckout__address-switch">
                                <div class="ty-profile-field__switch-label">
                                    <label class="{if $question.required == "YesNo::YES"|enum}cm-required{/if}" for="question_{$question.question_id}">{$question.title} &nbsp;</label>
                                </div>
                                <div class="ty-profile-field__switch-actions">
                                    <input type="hidden" name="checkout_questions_data[{$question.question_id}]" value="{"YesNo::NO"|enum}" data-ca-lite-checkout-field="{$field_name_helper}" />
                                    <input class="checkbox"
                                            id="question_{$question.question_id}"
                                            type="checkbox"
                                            name="checkout_questions_data[{$question.question_id}]"
                                            value="{"YesNo::YES"|enum}"
                                            data-ca-lite-checkout-field="{$field_name_helper}"
                                            data-ca-lite-checkout-auto-save="true"
                                            autocomplete="{$field.autocomplete}"
                                            aria-label="{$field.description}"
                                            title="{$field.description}"
                                            {if {$answer.{$question.question_id}.value} == "YesNo::YES"|enum}checked{/if}
                                            {$field.attributes|render_tag_attrs nofilter}
                                        />
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- checkbox block -->
                    <!-- input text -->
                    {elseif $question.type == "ProductOptionTypes::INPUT"|enum}
                    <div class="litecheckout__group">
                        <div class="litecheckout__item">
                            <label class="litecheckout__item {if $question.required == "YesNo::YES"|enum}cm-required{/if}" for="question_{$question.question_id}">{$question.title}:</label>
                        </div>
                        <div class="litecheckout__field litecheckout__field--fill cm-field-container">
                            <input
                                type="text"
                                id="question_{$question.question_id}"
                                placeholder=" "
                                name="checkout_questions_data[{$question.question_id}]"
                                value="{$answer.{$question.question_id}.value}"
                                class="litecheckout__input"
                            />
                            <span class="litecheckout__label {if $question.required == "YesNo::YES"|enum}cm-required{/if}" for="question_{$question.question_id}">{$question.title}</span>
                        </div>
                    </div>
                    <!-- input text -->
                    <!-- textarea -->
                    {elseif $question.type == "ProductOptionTypes::TEXT"|enum}
                    <div class="litecheckout__group">
                        <div class="litecheckout__item">
                            <label class="litecheckout__item {if $question.required == "YesNo::YES"|enum}cm-required{/if}" for="question_{$question.question_id}">{$question.title}:</label>
                        </div>
                        <div class="litecheckout__field">
                            <textarea class="litecheckout__input litecheckout__input--textarea"
                                id="question_{$question.question_id}"
                                name="checkout_questions_data[{$question.question_id}]"
                                placeholder=" "
                                data-ca-lite-checkout-field="{$field_name_helper}"
                                data-ca-lite-checkout-auto-save="true"
                                aria-label="{$field.description}"
                                title="{$field.description}"
                                {$field.attributes|render_tag_attrs nofilter}
                            >{$answer.{$question.question_id}.value}</textarea>
                            <span class="litecheckout__label {if $question.required == "YesNo::YES"|enum}cm-required{/if}" for="question_{$question.question_id}">{$question.title}</span>
                        </div>
                    </div>
                    <!-- textarea -->
                    {/if}
                    </div>
                </div>
            </div>
            {/foreach}
            <!-- questions block -->
        </div>
    </div>
{/foreach}
{else}
    <div class="litecheckout__container">
        <div class="litecheckout__container">
            <!-- title -->
            <div class="litecheckout__group">
                <div class="litecheckout__item ">
                    <h2 class="litecheckout__step-title">{$block_title|default:__("checkout_questions")}</h2>
                </div>
            </div>
            <!-- title -->
            
            <!-- questions block -->
            {foreach from=$checkout_questions item="question"}
            <div class="cm-processing-personal-data" data-ca-processing-personal-data-without-click="true">
                <div class="litecheckout__group">
                    <div class="litecheckout__group">
                    <!-- selectbox block -->
                    {if $question.type == "ProductOptionTypes::SELECTBOX"|enum}
                        <div class="litecheckout__item">
                            <label class="litecheckout__item {if $question.required == "YesNo::YES"|enum}cm-required{/if}" for="question_{$question.question_id}">{$question.title}:</label>
                        </div>
                        <div class="litecheckout__field cm-field-container litecheckout__field--small ">
                            <select class="litecheckout__input litecheckout__input--selectable "
                                    id="question_{$question.question_id}"
                                    data-ca-lite-checkout-field="{$field_name_helper}"
                                    data-ca-lite-checkout-auto-save-on-change="true"
                                    aria-label="{$question.title}"
                                    title="{$question.title}"
                                    name="checkout_questions_data[{$question.question_id}]"
                            >
                                {if $question.required == "YesNo::NO"|enum}
                                    <option value="">--</option>
                                {/if}
                                {foreach from=$question.variants item="variant"}
                                    <option {if {$answer.{$question.question_id}.value} == $variant.variant}selected{/if} value="{$variant.variant}">{$variant.variant}</option>
                                {/foreach}
                            </select>
                            
                        </div>
                    <!-- selectbox block -->
                    <!-- checkbox block -->
                    {elseif $question.type == "ProductOptionTypes::CHECKBOX"|enum}
                    <div class="litecheckout__group">
                        <div class="litecheckout__item" style="width: 100%;">
                            <div class="ty-profile-field__switch ty-address-switch clearfix litecheckout__address-switch">
                                <div class="ty-profile-field__switch-label">
                                    <label class="{if $question.required == "YesNo::YES"|enum}cm-required{/if}" for="question_{$question.question_id}">{$question.title} &nbsp;</label>
                                </div>
                                <div class="ty-profile-field__switch-actions">
                                    <input type="hidden" name="{$field_name}" value="{"YesNo::NO"|enum}" data-ca-lite-checkout-field="{$field_name_helper}" />
                                    <input class="checkbox"
                                            id="question_{$question.question_id}"
                                            type="checkbox"
                                            name="checkout_questions_data[{$question.question_id}]"
                                            value="{"YesNo::YES"|enum}"
                                            data-ca-lite-checkout-field="{$field_name_helper}"
                                            data-ca-lite-checkout-auto-save="true"
                                            autocomplete="{$field.autocomplete}"
                                            aria-label="{$field.description}"
                                            title="{$field.description}"
                                            {if {$answer.{$question.question_id}.value} == "YesNo::YES"|enum}checked{/if}
                                            {$field.attributes|render_tag_attrs nofilter}
                                        />
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- checkbox block -->
                    <!-- input text -->
                    {elseif $question.type == "ProductOptionTypes::INPUT"|enum}
                    <div class="litecheckout__group">
                        <div class="litecheckout__item">
                            <label class="litecheckout__item {if $question.required == "YesNo::YES"|enum}cm-required{/if}" for="question_{$question.question_id}">{$question.title}:</label>
                        </div>
                        <div class="litecheckout__field litecheckout__field--fill cm-field-container">
                            <input
                                type="text"
                                id="question_{$question.question_id}"
                                placeholder=" "
                                name="checkout_questions_data[{$question.question_id}]"
                                value="{$answer.{$question.question_id}.value}"
                                class="litecheckout__input"
                            />
                            <span class="litecheckout__label {if $question.required == "YesNo::YES"|enum}cm-required{/if}" for="question_{$question.question_id}">{$question.title}</span>
                        </div>
                    </div>
                    <!-- input text -->
                    <!-- textarea -->
                    {elseif $question.type == "ProductOptionTypes::TEXT"|enum}
                    <div class="litecheckout__group">
                        <div class="litecheckout__item">
                            <label class="litecheckout__item {if $question.required == "YesNo::YES"|enum}cm-required{/if}" for="question_{$question.question_id}">{$question.title}:</label>
                        </div>
                        <div class="litecheckout__field">
                            <textarea class="litecheckout__input litecheckout__input--textarea"
                                id="question_{$question.question_id}"
                                name="checkout_questions_data[{$question.question_id}]"
                                placeholder=" "
                                data-ca-lite-checkout-field="{$field_name_helper}"
                                data-ca-lite-checkout-auto-save="true"
                                aria-label="{$field.description}"
                                title="{$field.description}"
                                {$field.attributes|render_tag_attrs nofilter}
                            >{$answer.{$question.question_id}.value}</textarea>
                            <span class="litecheckout__label {if $question.required == "YesNo::YES"|enum}cm-required{/if}" for="question_{$question.question_id}">{$question.title}</span>
                        </div>
                    </div>
                    <!-- textarea -->
                    {/if}
                    </div>
                </div>
            </div>
            {/foreach}
            <!-- questions block -->
        </div>
    </div>
{/if}
{/if}