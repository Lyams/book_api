[![CI](https://github.com/Lyams/book_api/actions/workflows/ci.yml/badge.svg)](https://github.com/Lyams/book_api/actions/workflows/ci.yml)
[![Test Coverage](https://codecov.io/gh/lyams/book_api/graph/badge.svg)](https://codecov.io/gh/lyams/book_api)
# README
В процессе чтения книги Api Rails 6 by Alexandre Rousesau.
По книге в основном иду в этом проекте, но с Rspec и немного
больше тестов. Кроме того прикрутил CI и Codecov.

Bash-запрос для промежуточного использования ("троганья"):
curl --header "Content-Type: application/json" --request POST --data ' {"user": {"email": "www@em.em","password": "111"}}' http://127.0.0.1:3000/api/v1/users