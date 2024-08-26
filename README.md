<p align="center">
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://static.artemayer.ru/images/github/logo-wc/logo-wc_3x.png">
  <source media="(prefers-color-scheme: light)" srcset="https://static.artemayer.ru/images/github/logo-bc/logo-bc_3x.png">
  <img src="https://static.artemayer.ru/images/github/logo-bc/logo-bc_3x.png" height="140" alt="MEOWLS Server">
</picture> 
</p>

<br>

**MEOWLS Server** - это сервер, предназначенный для тестирования и разработки API приложения онлайн-магазина MEOWLS, специализирующегося на продаже товаров для животных.

## Содержание

- [Основные возможности](#основные-возможности)
- [Технологии и инструменты](#технологии-и-инструменты)
- [Структура проекта](#структура-проекта)
- [Структура базы данных](#структура-базы-данных)
- [Используемые паттерны проектирования](#используемые-паттерны-проектирования)
- [Установка и запуск](#установка-и-запуск)
  - [1. Клонирование репозитория](#1-клонирование-репозитория)
  - [2. Создание и запуск БД Postgres с использованием Docker:](#2-создание-и-запуск-бд-postgres-с-использованием-docker)
    - [2.1. Создание внутренней сети Docker для связи контейнеров базы данных и сервера](#21-создание-внутренней-сети-docker-для-связи-контейнеров-базы-данных-и-сервера)
    - [2.2. Запуск БД Postgres](#22-запуск-бд-postgres)
  - [3. Создание и запуск сервера с использованием Docker:](#3-создание-и-запуск-сервера-с-использованием-docker)
    - [3.1. Сборка Docker изображения](#31-сборка-docker-изображения)
    - [3.2. Запуск Docker контейнера](#32-запуск-docker-контейнера)
    - [3.3. Тестовый запрос к запущенному серверу](#33-тестовый-запрос-к-запущенному-серверу)
- [Примеры использования API](#примеры-использования-api)

## Основные возможности

- **API**: реальный сервер с поддержкой всех ключевых операций — управление товарами, пользователями, корзиной, избранным, главной страницой с баннерами, акциями и заказами.
- **Безопасность**: общий функционал открыт по определенным эндпоинтам, остальные закрыты аутентификацией по токену.
- **Интеграция с базой данных**: используется Fluent ORM для работы с базой данных POSTGRES.
- **Контейнеризация**: проект поддерживает развертывание в Docker, что упрощает его запуск и тестирование.


## Технологии и инструменты

- **Swift**: основной язык программирования проекта.
- **Vapor**: веб-фреймворк для разработки серверных приложений на Swift.
- **Fluent**: ORM для работы с базами данных.
- **Docker**: контейнеризация приложения для упрощенного развертывания и тестирования.


## Структура проекта

```plaintext
MEOWLSServer/
├── Sources/                         # Исходные коды приложения
│   ├── App/                         # Основное приложение
│   │   ├── Configuration/           # Конфигурация приложения
│   │   ├── Controllers/             # Контроллеры для обработки запросов
│   │   ├── Extensions/              # Расширения общих типов Foundation и объектов Vapor
│   │   ├── Fluent/                  # Специфичный код для расширения функционала Fluent ORM
│   │   │    ├── Authentication/     # Кастомная аутентификация пользователя через токен
│   │   │    └── Paginator/          # Кастомный пагинатор. Пагинация для запросов к БД и ответа клиенту.
│   │   ├── Helpers/                 # Различные вспомогательные объекты
│   │   │    ├── Builders/           # Паттерн строитель для сборки DTO моделей и сырых SQL запросов
│   │   │    ├── DTOFactory/         # Фабрика создания DTO моделей
│   │   │    ├── ErrorFactory/       # Фабрика создания ошибок сервера для отправки клиенту
│   │   │    ├── OrderJobs/          # Задачи и планировщик для работы с заказами
│   │   │    └── typealiases.swift   # Псевдонимы для внутренних типов 
│   │   ├── Migrations/              # Миграция/создание таблиц в базе данных
│   │   ├── Models/                  # Модели
│   │   │   ├── DBEntity/            # Сущности базы данных
│   │   │   └── NetworkModel/        # DTO модели
│   │   ├── Routes/                  # Регистрирование маршрутов для API
│   │   ├── Vapor/                   # Специфичный код для расширения функционала Vapor
│   │   │   ├──Authentication/       # Кастомная аутентификация пользователя через токен
│   │   │   └──ExtendedError/        # Кастомная обёртка Vapor ошибок + подмена внутренних AbortError на собственные
│   │   ├── AppConstants.swift       # Общие константы приложения
│   │   └── Entrypoint.swift         # Точка входа
├── Tests/                           # Тесты
├── Dockerfile                       # Docker-конфигурация
├── docker-compose.yml               # Файл конфигурации Docker Compose
├── LICENSE                          # Файл лицензии
└── README.MD                        # README файл с описанием проекта, инструкциями
```

## Структура базы данных



## Используемые паттерны проектирования

- Структурное разделение кода на контроллеры, модели и маршруты.
- **Builder**: используется для сборки DTO моделей и сырых SQL запросов
- **Factory**: используются для создания всех DTO моделей и ошибок на сервере, возвращаемых клиенту 
- **Dependency Injection**: используется для управления зависимостями.
- **Repository Pattern**: управление доступом к данным через абстракцию Fluent ORM.

## Установка и запуск

### 1. Клонирование репозитория:
```zsh
git clone https://github.com/mayer1a/MEOWLSServer.git
cd MEOWLSServer
```

---

> [!IMPORTANT]
> Для продолжения убедитесь, что у вас установлены Docker.

### 2. Создание и запуск БД Postgres с использованием Docker:

#### 2.1. Создание внутренней сети Docker для связи контейнеров базы данных и сервера
```zsh
docker network create -d bridge {DOCKER_NETWORK_NAME}
```
где `{DOCKER_NETWORK_NAME}` произвольное название внутренней сети

> [!TIP]
> Если у вас уже установлена и запущена база данных, то необходимо добавить её во внутреннюю сеть Docker:\
> `docker network connect {YOUR_NETWORK_NAME} {YOUR_DATABASE_CONTAINER_NAME_OR_ID}`.\
> А затем переходите к [пункту 3](#3-создание-и-запуск-сервера-с-использованием-docker)

#### 2.2. Запуск БД Postgres
Воспользуемся готовым контейнером Postgres запустив его следующей командой:
```zsh
docker run -d --restart=always \
--network {DOCKER_NETWORK_NAME} \
-e POSTGRES_DB={DATABASE_NAME} \
-e POSTGRES_USER={DATABASE_USER} \
-e POSTGRES_PASSWORD={DATABASE_PASSWORD} \
-e POSTGRES_HOST={DATABSE_HOST} \
-e POSTGRES_PORT={DATABASE_PORT} \
-p {DOCKER_PORT_FORWARDING} \
postgres:16-alpine
```
где вместо `{DOCKER_NETWORK_NAME}` - указанное Вами, название внутренней сети Docker;\
`{DATABASE_NAME}` - название базы данных;\
`{DATABASE_USER}` - имя пользователя базы данных;\
`{DATABASE_PASSWORD}` - пароль к базе данных;\
`{DATABSE_HOST}` - хост, по которой будет доступна база данных, по умолчанию использовать `localhost`;\
`{DATABASE_PORT}` - порт базы данных, по умолчанию использовать `5432`;\
`{DOCKER_PORT_FORWARDING}` - проброс портов для Docker к базе данных, по умолчанию использовать `5432:5432`.

> [!WARNING]
> Необходимо проверить, что контейнер базы данных был загружен и запущен\
> Выполнив команду `docker ps`, Вы должны увидеть в столбце `IMAGE` название изображения postgres:16-alpine, столбец `STATUS` для этого контейнера `UP {N} ago`

---

### 3. Создание и запуск сервера с использованием Docker:
Для того, чтобы запустить сервер, потребуется две команды - на сборку и запуск.

#### 3.1. Сборка Docker изображения
```zsh
docker build -t {SERVER_NAME} .
```
где вместо `{SERVER_NAME}` подставьте название сервера, например ```docker build -t meowls_server  .```.

> [!WARNING]
> Необходимо проверить, что изображение было создано и с верным названием\
> Выполнив команду `docker images`, Вы должны увидеть в столбце `REPOSITORY` название Вашего сервера

#### 3.2. Запуск Docker контейнера
```zsh
docker run --restart=always \
--name {SERVER_NAME} \
--network {DOCKER_NETWORK_NAME} \
-e DATABASE_HOST=postgres \
-e DATABASE_NAME={DATABASE_NAME} \
-e DATABASE_PASSWORD={DATABASE_PASSWORD} \
-e DATABASE_USERNAME={DATABASE_USER} \
-e DADATA_TOKEN={YOUR_DADATA_API_TOKEN} \
-p 8080:8080 \
-d meowls_server:latest
```
где вместо `{SERVER_NAME}` - указанное Вами, название сервера ;
`{DOCKER_NETWORK_NAME}` - указанное Вами, название внутренней сети Docker;\
`{DATABASE_NAME}` - указанное Вами, название базы данных;\
`{DATABASE_USER}` - указанное Вами, имя пользователя базы данных;\
`{DATABASE_PASSWORD}` - указанный Вами, пароль к базе данных;\
`{YOUR_DADATA_API_TOKEN}` - для этого нужно [зарегестрироваться в DaData](https://dadata.ru/#registration_popup) и получить в личном кабинете. Либо указать `""`, но подсказки ФИО и адресов работать не будут;\
`{DATABASE_PORT}` - указанный Вами, порт базы данных, по умолчанию использовать `5432`;\
`{DOCKER_PORT_FORWARDING}` - указанная Вами, связь портов для Docker к базе данных, по умолчанию использовать `5432:5432`.

> [!WARNING]
> Необходимо проверить, что контейнер был создан и запущен\
> Выполнив команду `docker ps`, Вы должны увидеть в столбце `IMAGE` название Вашего сервера {SERVER_NAME}:latest, а в столбце `STATUS` для этого контейнера `UP {N} ago`

> [!TIP]
> После запуска сервер будет доступен по адресу http://localhost:8080.

---

#### 3.3. Тестовый запрос к запущенному серверу
Воспользуемся терминалом и отправим команду (Unix) `curl --location 'localhost:8080/health-check'`.\
Если вы получили в ответ сообщение `{}%`, то всё работает!

---

### Примеры использования API

> [!TIP]
> Все запросы описаны в [файле ROUTES.MD](.github/Resources/ROUTES.MD)

#### Регистрация пользователя

<details>
  <summary>Раскрыть CURL запрос</summary>
  
  ```zsh
  curl --location 'localhost:8080/api/v1/users/create' \
  --header 'Content-Type: application/json' \
  --data-raw '{
      "surname": "Userson",
      "name": "User",
      "patronymic": "Usersed",
      "email": "user@example.com",
      "phone": "79139139113",
      "gender": "man",
      "password": "uNhsyBu28d",
      "confirm_password": "uNhsyBu28d"
  }'
  ```
</details>

---

#### Авторизация пользователя

<details>
  <summary>Раскрыть CURL запрос</summary>
  
  ```zsh
  curl --location --request POST 'localhost:8080/api/v1/users/login' \
  --header 'Authorization: Basic Nzk5MzEyMnMzMzM6QWGjZGVmMTSxMQ=='
  ```
</details>

---

#### Получение главной страницы с баннерами

<details>
  <summary>Раскрыть CURL запрос</summary>
  
  ```zsh
  curl --location 'localhost:8080/api/v1/main_page'
  ```
</details>

---

#### Получение списка подкатегорий

<details>
  <summary>Раскрыть CURL запрос</summary>
  
  ```zsh
  curl --location 'localhost:8080/api/v1/categories?category_id=E4960D2C-CA4C-466A-926E-F77CDA1059E9'
  ```
</details>

---

#### Получение списка товаров с пагинацией

<details>
  <summary>Раскрыть CURL запрос</summary>
  
  ```zsh
  curl --location 'localhost:8080/api/v1/products?category_id=CC924CC5-9A10-4EC4-92DB-01B987D02B3C&page=1&per_page=20'
  ```
</details>

---

#### Получение детализированного товара

<details>
  <summary>Раскрыть CURL запрос</summary>
  
  ```zsh
  curl --location 'localhost:8080/api/v1/products/D7D1492D-850F-4B72-B60C-9CB9B3B9D68D'
  ```
</details>

---

#### Получение корзины

<details>
  <summary>Раскрыть CURL запрос</summary>
  
  ```zsh
  curl --location 'localhost:8080/api/v1/cart' \
  --header 'Authorization: Token i9RPvWXK9S7xFHbF+W0wl/3rUc3z5mvRWlcSKOwPZqA='
  ```
</details>

---

#### Получение избранных товаров для авторизованного пользователя

<details>
  <summary>Раскрыть CURL запрос</summary>
  
  ```zsh
  curl --location 'localhost:8080/api/v1/favorites/' \
  --header 'Authorization: Token i9RPvWXK9S7xFHbF+W0wl/3rUc3z5mvRWlcSKOwPZqA='
  ```
</details>

---

## Поддержка и вклад

Мы рады любым предложениям по улучшению проекта. Для этого создайте форк репозитория и отправьте Pull Request.

## Помощь

Если тебе нужно связаться со мной или получить помощь по проекту, 
то не стесняйся - пиши на <a href="mailto:mayer1art@gmail.com">почту</a> и в <a href="https://t.me/mayer1a">телеграм</a>

## Лицензия

Проект лицензирован под GPL-3.0 License. Подробности смотрите в файле [LICENSE](./LICENSE).
