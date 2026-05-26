#!/bin/bash

echo "Esperando a Postgres..."

until python3 -c "
import psycopg2
psycopg2.connect(
    host='db',
    port='5432',
    dbname='notesdb',
    user='postgres',
    password='cambiar_en_produccion'
)
print('ok')
"; do
    echo 'Postgres no disponible, reintentando en 2s...'
    sleep 2
done

echo "Postgres listo. Iniciando app..."

python3 -c "import app; app.init_db()" || true

exec "$@"
