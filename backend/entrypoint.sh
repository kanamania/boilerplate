#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST_POSTGRES $SQL_PORT_POSTGRES; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

if [ "$DATABASE" = "mysql" ]
then
    echo "Waiting for mysql..."

    while ! nc -z $SQL_HOST_MYSQL $SQL_PORT_MYSQL; do
      sleep 0.1
    done

    echo "MySQL started"
fi

#python manage.py flush --no-input
python manage.py makemigrations
python manage.py migrate

exec "$@"