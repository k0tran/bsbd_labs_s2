#import "template.typ": *
#show: lab.with(n: 1)

= Диаграмма сущностей и разделение на схемы

Для начала напомню, что база данных, разработанная в предыдущем семестре используется в гипотетическом канцелярском магазине. Product это конкретная единица товара, Product Type - "род" товара. Так же учитываются поставки и продажи, на оба события назначается ответственный работник/кассир.

#pic(img: "lab1/diagram.png")[Диаграмма сущностей]

Далее по заданию необходимо разделить сущности на схемы при необходимости. Я посчитал полезным ограничить примерные границы для ролей следующим образом:
- PDB (Product DataBase) - все что относится к данным о продуктах в целом:
  - Product Type
  - Country
  - Vendor
  - Category
- inventory - продукты на витринах:
  - Product
- sales - все что относится к продажам:
  - Sale
  - Customer
- staff - менеджмент сотрудников:
  - Employee
  - Job
- logistics - поставки:
  - Supply

Можно заметить, что в inventory и logistics только по одному элементу. Это сделано для того что бы все оставалось организованным и при этом не хранилось в public, так как с полными привилегиями по умолчанию можно легко накосячить.

Для того что бы добавить схему необходимо прописать
```sql
CREATE SCHEMA pdb;
```
И после использовать префикс в виде схемы в названии таблицы (например вместо product pdb.product).

#pagebreak()

= Роли

После разбиения на схемы было решено ввести 4 роли: роль для модификации pdb, роль для продаж (кассиры), роль для hr'ов и роль для управления логистикой (какие-нибудь менеджеры):
- pdb_role
  - SELECT, INSERT, UPDATE, DELETE на pdb
- sales_role - роль "продавца", списывает продукты, добавляет sale'ы.
  - SELECT, INSERT, UPDATE, DELETE на sales
  - SELECT, UPDATE на inventory (там только bool поставить надо)
- staff_role - роль для HR'ов:
  - SELECT, INSERT,   UPDATE, DELETE на staff
  - SELECT на sales (для того что бы потенциально смотреть насколько каждый сотрудник эффективен)
- logistics_role - роль для управления поставками:
  - SELECT, INSERT, UPDATE, DELETE на logistics и inventory

Важно отметить, что особо глубокого смысла в данном разделении нет, я просто подумал про справедливые, но строгие требования и написал их как вижу.

Также замечу, что ни одна роль не имеет системных привелегий. Это потому, что они здесь не должны быть. Данная архитектура уже предусматривает добавление товара и его параметров. Если все-таки бд необходимо будет перестроить, то это уже будут кардинальные изменения. В таком случае разумно использовать суперпользователя.

#pagebreak()

= Проверка ролей

== Краткий экскурс в postgres

При выполнении лабораторных я использовал docker образ postgres. Что бы поднять его у себя сначала пуллим, а затем, собственно, поднимаем (user:user простой тестовый пароль):
```sh
sudo docker pull postgres
sudo docker run -itd -e POSTGRES_USER=user -e POSTGRES_PASSWORD=user -p 5432:5432 -v /data:/var/lib/postgresql/data --name postgresql postgres
```

После этого подключится к серверу в качестве user с той же машины можно будет следующей командой:
```sh
PGPASSWORD=user psql -U user -d mydb -h localhost
```

Если у вас пишет, что mydb не существует, то просто создайте ее от имени user:
```sh
PGPASSWORD=user psql -U user -h localhost -c "CREATE DATABASE mydb;"
```

Напоследок отмечу, что выполнить просто команды можно через `-c`, выполнить файл через `-f`. Файл `setup.sql` используется для создания тестовой бд.

== Просмотр pg_roles

Для того что бы быстро задавать использовался файл setup.sql (см приложение).

Зайдем на сервер и просмотрим pg_roles

#pic(img: "lab1/pg_roles.png")[pg_roles]

Как можно убедится, ни одна роль не имеет системных привелегий. Теперь пройдемся по ролям.

== pdb_role

```sql
-- should allow
SELECT vendor FROM pdb.product_type;

-- should deny
SELECT salary, days_per_week FROM sales.employee;
```

#pic(img: "lab1/r_pdb.png")[Тест роли (1)]

== sales_role

```sql
-- should allow
SELECT price FROM inventory.product;

-- should deny
DELETE FROM inventory.product WHERE price > 1000;
```

#pic(img: "lab1/r_sales.png")[Тест роли (2)]

== staff_role

```sql
-- should allow
SELECT name FROM staff.employee;

-- should deny
DELETE FROM inventory.product WHERE price > 1000;
```

#pic(img: "lab1/r_staff.png")[Тест роли (3)]

== logistics

```sql
-- should allow
SELECT price FROM inventory.product;

-- should deny
SELECT salary, days_per_week FROM sales.employee;
```

#pic(img: "lab1/r_logistics.png")[Тест роли (4)]

#pagebreak()

// Костыль что бы заголовки были без номера
#set heading(numbering: (..numbers) =>
  if numbers.pos().len() <= 0 { return "" }
)

#endhead[Заключение]

В данной лабораторной работе были рассмотрены такие важные аспекты PostgreSQ как схемы и роли. Сначала были выбраны наиболее подходящие схемы, а затем определены роли, соответствующие функционалу канцелярского магазина. Также было произведено подключение и проверка привилегий ролей, чтобы убедиться, что они соответствуют ожиданиям.

#pagebreak()

#endhead[Приложение А]

Код setup.sql

#let text = read("../playground/setup.sql")
#raw(text, lang: "sql")