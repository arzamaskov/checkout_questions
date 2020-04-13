# CS-Cart add-on "Chechout questions"

This add-on allows the store administrator to create checkout questions, edit and delete them easily.

![Screenshot checkout questions admin](/screenshots/Screen_questions_admin_en.png)

There are the following questions types: checkbox, select box, input text, and text area. The question can be mandatory or not and have the statuse: "active", "hidden" and "disabled".

A list of questions with the "active" status is available to the customer on the checkout page.

![Screenshot checkout questions in storefront](/screenshots/Screen_questions_storefront_en.png)

Questions and answers to them can be seen on the detailed order page and in email notifications from both the administrator and the customer.

![Screenshot checkout questions in the admin order page](/screenshots/Screen_questions_order_admin_en.png)

![Screenshot checkout questions in the customer order page](/screenshots/Screen_questions_order_storefront_en.png)

## Setting email notifications

1. In the menu item `Administration - Notifications - Document` choose the document you need. "Invoice" - for printing, "Order summary" - for mail notifications.

![Screenshot menu](/screenshots/Screen_menu_en.png)

![Screenshot documents](/screenshots/Screen_documents_en.png)

2. In the sidebar in the `order` class, find the `checkout_questions` variable. This variable contains an array of questions and answers.

![Screenshot order class](/screenshots/Screen_order_class_en.png)

![Screenshot checkout_questions variable](/screenshots/Screen_checkout_questions_variable_en.png)

3. To correct display questions of the variable `checkout_questions` need to create a new snippet. To do this, on the `Code snippets` tab, select `Add snippet`.

![Screenshot code snippet tab](/screenshots/Screen_code_snippet_tab_en.png)

It recommends using the following snippet template or a similar one:

Name: Checkout questions
Code: checkout_questions
Template:

```
<h2>{{__("CHECKOUT_QUESTIONS")}}</h2>

<table>
    {% for item in  o.checkout_questions %}
        <tr>
            <td style="padding-top: 20px; border-bottom: 1px solid #e8e8e8;">{{ item.title }}</td>
            <td style="padding-top: 20px; border-bottom: 1px solid #e8e8e8;">
            {% if item.value == 'Y' %} {{__("YES")}} {%elseif item.value == 'N' %} {{__("NO")}} {% else %} {{ item.value }} {% endif %}
            </td>
        </tr>
    {% endfor %}
</table>
```

![Screenshot snippet template](/screenshots/Screen_snippet_template_en.png)

4. Add the created snippet to the document.

![Screenshout snippet in document](/screenshots/Screen_snippet_in_document_en.png)

![Screenshot checkout questions in an invoice](/screenshots/Screen_questions_invoice_en.png)

# CS-Cart модуль "Вопросы в блоке оформления заказа"

Этот модуль позволяет администратору магазина легко создавать вопросы для блока оформления товара, редактировать и удалять их.

![Screenshot checkout questions admin](/screenshots/Screen_questions_admin_ru.png)

Доступны следующие типы вопросы типов: флажок, список вариантов, текст и текстовая область. Вопрос может быть обязательным или нет и иметь статус "включено", "скрытый" и "выключено".

Список вопросов со статусом "включено" доступен покупателю на странице оформления заказа.

![Screenshot checkout questions in storefront](/screenshots/Screen_questions_storefront_ru.png)

Вопросы и полученные ответы на них можно увидеть на детальной странице заказа и в уведомлениях на почте как у администратора, так и у клиента.

![Screenshot checkout questions in the admin order page](/screenshots/Screen_questions_order_admin_ru.png)

![Screenshot checkout questions in the customer order page](/screenshots/Screen_questions_order_storefront_ru.png)

## Настройка уведомлений на почту

1. В пункте меню `Администрирование - Уведомления - Документы` выбрать необходимый документ. "Счет" - для распечатки, "Детали заказа" - для почтовых уведомлений.

![Screenshot menu](/screenshots/Screen_menu_ru.png)

![Screenshot documents](/screenshots/Screen_documents_ru.png)

2. В боковой панели в классе `order` найти переменную `checkout_questions`. Эта переменная содержит массив вопросов и ответов.

![Screenshot order class](/screenshots/Screen_order_class_ru.png)

![Screenshot checkout_questions variable](/screenshots/Screen_checkout_questions_variable_ru.png)

3. Для корректного вывода вопросов из переменной `checkout_questions` нужно создать новый сниппет. Для этого, на вкладке `Сниппеты` выбрать `Добавить сниппет`.

![Screenshot code snippet tab](/screenshots/Screen_code_snippet_tab_ru.png)

Рекомендуется использовать следующий, либо аналогичный шаблон сниппета:

Название: Checkout Questions  
Код: checkout_questions
Шаблон:

```
<h2>{{__("CHECKOUT_QUESTIONS")}}</h2>

<table>
    {% for item in  o.checkout_questions %}
        <tr>
            <td style="padding-top: 20px; border-bottom: 1px solid #e8e8e8;">{{ item.title }}</td>
            <td style="padding-top: 20px; border-bottom: 1px solid #e8e8e8;">
            {% if item.value == 'Y' %} {{__("YES")}} {%elseif item.value == 'N' %} {{__("NO")}} {% else %} {{ item.value }} {% endif %}
            </td>
        </tr>
    {% endfor %}
</table>
```

![Screenshot snippet template](/screenshots/Screen_snippet_template_ru.png)

4. Добавить созданный сниппет в документ.

![Screenshout snippet in document](/screenshots/Screen_snippet_in_document_ru.png)

![Screenshot checkout questions in an invoice](/screenshots/Screen_questions_invoice_ru.png)
