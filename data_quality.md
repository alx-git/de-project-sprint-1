## Оцените, насколько качественные данные хранятся в источнике.
Опишите, как вы проверяли исходные данные и какие выводы сделали.

Дубли отcутствуют в таблицах orders, users (сравннение общего количества записей с количеством уникальных значений по ключу).
Пропущенные значения отсутствуют для колонок orders.order_id, orders.payment, orders.order_ts, orders.status (поиск null значений).
Для обеспечения качества данных в таблицах в схемах production используются типы данных, первичные ключи, внешние ключи, ограничения, проверки.

## Укажите, какие инструменты обеспечивают качество данных в источнике.
Ответ запишите в формате таблицы со следующими столбцами:
- `Наименование таблицы` - наименование таблицы, объект которой рассматриваете.
- `Объект` - Здесь укажите название объекта в таблице, на который применён инструмент. Например, здесь стоит перечислить поля таблицы, индексы и т.д.
- `Инструмент` - тип инструмента: первичный ключ, ограничение или что-то ещё.
- `Для чего используется` - здесь в свободной форме опишите, что инструмент делает.

| Таблицы             | Объект                      | Инструмент      | Для чего используется                |
| ------------------- | --------------------------- | --------------- | ---------------------                |
| production.products | id int NOT NULL PRIMARY KEY | Первичный ключ  | Обеспечивает уникальность записей    |
| production.users    | id int NOT NULL PRIMARY KEY | Первичный ключ  | Обеспечивает уникальность записей    |
| production.orderstatuses    | id int NOT NULL PRIMARY KEY | Первичный ключ  | Обеспечивает уникальность записей    |
| production.orders | order_id int NOT NULL PRIMARY KEY | Первичный ключ  | Обеспечивает уникальность записей    |
| production.orderitems | id int NOT NULL PRIMARY KEY | Первичный ключ  | Обеспечивает уникальность записей    |
| production.orderstatuslog | id int NOT NULL PRIMARY KEY | Первичный ключ  | Обеспечивает уникальность записей    |
| production.orderitems | CHECK (((discount >= (0)::numeric) AND (discount <= price))) | Проверка  | Проверка, что скидка неотрицательна и не больше цены     |
| production.orderitems | CHECK ((price >= (0)::numeric)) | Проверка  | Проверка, что цена неотрицательна     |
| production.orderitems | CHECK ((quantity > 0)) | Проверка  | Проверка, что количество положительно     |
| production.orders | CHECK ((cost = (payment + bonus_payment))) | Ограничение  | Проверка, что затраты равны выплате и бонусу     |
| production.products | CHECK ((price >= (0)::numeric)) | Проверка  | Проверка, что цена неотрицательна     |
| production.orderitems | FOREIGN KEY (order_id) REFERENCES production.orders(order_id) | Внешний ключ  | Обеспечивает связь с таблицей orders     |
| production.orderitems | FOREIGN KEY (product_id) REFERENCES production.products(id) | Внешний ключ  | Обеспечивает связь с таблицей products     |
| production.orderstatuslog | FOREIGN KEY (order_id) REFERENCES production.orders(order_id) | Внешний ключ  | Обеспечивает связь с таблицей orders     |
| production.orderstatuslog | FOREIGN KEY (status_id) REFERENCES production.orderstatuses(id) | Внешний ключ  | Обеспечивает связь с таблицей orderstatuses     |
| production.orderitems | UNIQUE (order_id, product_id) | Ограничение уникальности  | Не может быть дубликатов по полям  order_id, product_id вместе    |
| production.orderstatuslog | UNIQUE (order_id, status_id) | Ограничение уникальности  | Не может быть дубликатов по полям  order_id, status_id вместе    |
