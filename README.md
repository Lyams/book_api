[![CI](https://github.com/Lyams/book_api/actions/workflows/ci.yml/badge.svg)](https://github.com/Lyams/book_api/actions/workflows/ci.yml)
[![Test Coverage](https://codecov.io/gh/lyams/book_api/graph/badge.svg)](https://codecov.io/gh/lyams/book_api)
# README
В процессе чтения книги Api Rails 6 by Alexandre Rousesau.
По книге в основном иду в этом проекте, но с Rspec и немного
больше тестов, ограничений в семе БД, posgresql, и валидаций. Кроме того прикрутил CI и Codecov.

**Bash-запросы для промежуточного использования ("троганья"):**

Получение токена:
curl --header "Content-Type: application/json" --request POST --data ' {"user": {"email": "lyamsh@yandex.ru","password": "local123"}}' http://127.0.0.1:3000/api/v1/tokens

{ order: { product_ids_and_quantities: [ { product_id: 1, quantity: 2 },{ product_id: 3, quantity: 3 } ] } }

Пример создания товара:
curl --header "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE2NDI5NjYzNDV9.M8Q3C4hvV-jMffQccYHuj1eOa65csKPP4ziVO4RKJAw" http://localhost:3000/api/v1/products --request POST --data '{"product":{"price":100,"title":"Fignya","published":true,"quantity":100 }}' -H "Content-type: application/json"

Пример создания заказа:
curl --header "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE2NDI5NjYzNDV9.M8Q3C4hvV-jMffQccYHuj1eOa65csKPP4ziVO4RKJAw"  --request POST --data '{ "order": { "product_ids_and_quantities": [ { "product_id": "1", "quantity": "2" },{ "product_id": "3", "quantity": "3" } ] } }' http://127.0.0.1:3000/api/v1/orders -H "Content-type: application/json"