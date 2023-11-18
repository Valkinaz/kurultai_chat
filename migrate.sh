#!/bin/bash

# Для Windows: меняем CRLF на LF
echo "$(tr -d '\r' < .env.local)" > .env.local

export $(grep -v '^#' .env.local | xargs)

GID=$(id -g)
BASE_PATH=$(pwd)
MIGRATE_SQL_PATH="$BASE_PATH/migrations"

docker run \
    -v "$MIGRATE_SQL_PATH":/migrations \
    -u "$UID:$GID" \
    --network kurultai_chat_network \
    migrate/migrate:v4.14.1 \
        -path=/migrations/ -database "postgres://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB?sslmode=disable" $*
