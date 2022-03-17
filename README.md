[![CI](https://github.com/Lyams/book_api/actions/workflows/ci.yml/badge.svg)](https://github.com/Lyams/book_api/actions/workflows/ci.yml)
[![Test Coverage](https://codecov.io/gh/lyams/book_api/graph/badge.svg)](https://codecov.io/gh/lyams/book_api)
# README
Сделан в процессе чтения книги Api Rails 6 by Alexandre Rousesau и по её мотивам.
По книге в основном иду в этом проекте. Вместо RoR 6 и Ruby 2 я использовал Rails 7 и Ruby 3.
В книге использовался Minitest с небольшим количеством тестов - я использовал Rspec с большим количеством тестов, ограничений в схеме БД, СУБД posgresql, и большего количества валидаций в схеме.

Что еще не по книге:
Вместо дефолтного id настроил по-умолчанию uuid.
Кроме того прикрутил CI и Codecov.
Добавил GoodJob для отложенной асинхронной отправки писем и open_mailer для просмотра потсылаемого письма в development-окружении.
Добавил rspec-openapi для генерации документации.
Добавил полноценную валидацию с помощью valid_email2 - видимо лучше только отправка письма с ответом на него.
Добавил в CI линтер - Rubocop и утилиты для анализа безопастности - brakeman и bundle-audit.

<!--
**Примеры Bash-запросов для промежуточного использования ("троганья"):**

Получение токена:
```bash
curl --header "Content-Type: application/json" --request POST --data ' {"user": {"email": "lyamsh@yandex.ru","password": "local123"}}' http://127.0.0.1:3000/api/v1/tokens
```

Пример создания товара:
```bash
curl --header "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE2NDI5NjYzNDV9.M8Q3C4hvV-jMffQccYHuj1eOa65csKPP4ziVO4RKJAw" http://localhost:3000/api/v1/products --request POST --data '{"product":{"price":100,"title":"Fignya","published":true,"quantity":100 }}' -H "Content-type: application/json"
```

Пример создания заказа:
```bash
curl --header "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE2NDI5NjYzNDV9.M8Q3C4hvV-jMffQccYHuj1eOa65csKPP4ziVO4RKJAw"  --request POST --data '{ "order": { "product_ids_and_quantities": [ { "product_id": "1", "quantity": "2" },{ "product_id": "3", "quantity": "3" } ] } }' http://127.0.0.1:3000/api/v1/orders -H "Content-type: application/json"
```
