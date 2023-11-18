# Kurultai Chat
Бекенд приложение для чата на [gRPC](https://grpc.io/docs/what-is-grpc/introduction/) протоколе с [Protobuf](https://protobuf.dev/overview/) сериализацией данных

## Стек технологий
* Go 1.20
* PostgreSQL 14

## Локальная разработка
Для разворачивания локального окружения необходим установленный `docker` и `docker compose`  
Проект содержит `Makefile`, который обеспечивает быстрый доступ к основным командам.  
Для базового запуска необходимо:
```shell
cp .env.dist .env.local     # создать файл с переменными окружения со значениями из .env.dist
make build                  # подготовить контейнеры
make up                     # запустить контейнеры
./migrate.sh up             # выполнить все миграции
```
Приложение будет доступно для вызова по адресу localhost:50001. Порт зависит от установленного в `.env.local`

### Процесс разработки
В контейнер с Go установлен пакет [cosmtrek/air](https://github.com/cosmtrek/air), который самостоятельно отслеживает изменения в файлах, 
пересобирает и перезапускает приложение.   

### Миграции
Для миграций используется пакет [golang-migrate/migrate](https://github.com/golang-migrate/migrate), который доступ для использования через файл `migrate.sh`  
Примеры команд:
```shell
# Выполнить новые все миграции
./migrate.sh up

# Выполнить 2 новые миграции
./migrate.sh up 2

# Откатить 1 миграцию
./migrate.sh down 1

# Создать файл миграции с именем example и расширением sql
./migrate.sh create -ext sql -dir migrations/ example
```
