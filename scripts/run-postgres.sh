#!/usr/bin/env bash

# CONTAINER_NAME=dev-postgres
# POSTGRES_USER=myuser
# POSTGRES_PASSWORD=mypassword
# POSTGRES_DB=mydb
# POSTGRES_PORT=5432
#
# docker run -d \
#   --name $CONTAINER_NAME \
#   -e POSTGRES_USER=$POSTGRES_USER \
#   -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
#   -e POSTGRES_DB=$POSTGRES_DB \
#   -v pgdata:/var/lib/postgresql/data \
#   -p $POSTGRES_PORT:5432 \
#   postgres:latest
#
# echo "PostgreSQL is running at localhost:$POSTGRES_PORT"



docker stop dev-postgres
docker rm dev-postgres
docker volume rm pgdata

CONTAINER_NAME=dev-postgres
POSTGRES_USER=postgres
POSTGRES_PORT=5432

docker run -d \
  --name $CONTAINER_NAME \
  -e POSTGRES_HOST_AUTH_METHOD=trust \
  -e POSTGRES_USER=$POSTGRES_USER \
  -v pgdata:/var/lib/postgresql/data \
  -p $POSTGRES_PORT:5432 \
  postgres:latest

echo "PostgreSQL is running at localhost:$POSTGRES_PORT"
