#import "template.typ": *
#show: lab.with(n: 3)

= Начало работы

== БД и директория

Расположение кластера PostgreSQL по умолчанию:
- Linux: `/var/lib/postgresql/<version>/data`
- macOS: `/usr/local/var/postgres`
- Windows: `C:\Program Files\PostgreSQL\<version>\data`

Где version номер версии PostgreSQL.

#pic(img: "lab3/db1.png")[В моем случае используется специальная директория]

== Запуск и перезапуск

Запущен при помощи #link("https://github.com/docker-library/postgres/blob/master/docker-entrypoint.sh")[entrypoint]

В случае использования docker образа postgres гораздо разумнее перезапустить контейнер, нежели копаться в его внутренностях.

#pic(img: "lab3/restart.png")[Перезапуск контейнера postgres]

== Создаие

При запуске контейнера можно указать POSTGRES_USER и POSTGRES_PASSWORD. Используя их можно исполнить:
```sql
CREATE DATABASE mydb;
```

Владельцем будет POSTGRES_USER.

#pic(img: "lab3/create_newdb.png")[Создание новой бд и попытка чтения]

Больше чтения и работы с новой бд здесь не продемонстрированно так как это уже было сделано в перовой лабораторной (добавление таблиц, ролей, схем и тп.).

#pagebreak()

// Костыль что бы заголовки были без номера
#set heading(numbering: (..numbers) =>
  if numbers.pos().len() <= 0 { return "" }
)

#endhead[Заключение]

В данной лабораторной работе были рассмотрены основные аспекты работы с кластером postgres. Продемострирован способ работы в рамках docker контейнера.