#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd -- "$(dirname -- "$0")" && pwd)"
: "${DB_HOST:=localhost}"; : "${DB_PORT:=3306}"; : "${DB_USER:=root}"; : "${DB_NAME:=proyectocz}"
if [[ -z "${DB_PASSWORD+x}" ]]; then read -s -p "Contrasena MariaDB: " DB_PASSWORD; echo; fi
export MYSQL_PWD="$DB_PASSWORD"
mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -e "CREATE DATABASE IF NOT EXISTS \"$DB_NAME\" CHARACTER SET utf8mb4;"
mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" "$DB_NAME" < "$ROOT/sql/01_esquema.sql"
mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" "$DB_NAME" < "$ROOT/sql/02_datos.sql"
echo "Tablas y datos cargados. Importar manualmente funciones, procedimientos, triggers, seguridad y vistas en el orden documentado."
