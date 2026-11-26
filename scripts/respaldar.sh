#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/respaldo.env"
if [[ ! -f "$ENV_FILE" ]]; then echo "Falta scripts/respaldo.env (copie respaldo.env.ejemplo y configurelo)." >&2; exit 1; fi
source "$ENV_FILE"
BACKUP_DIR="${BACKUP_DIR:-./respaldos}"
mkdir -p "$BACKUP_DIR"
STAMP=$(date +%Y%m%d_%H%M%S)
OUT="$BACKUP_DIR/${DB_NAME}_${STAMP}.sql.gz"
MYSQL_PWD="${DB_PASSWORD:-}" mariadb-dump --host="${DB_HOST:-localhost}" --port="${DB_PORT:-3306}" --user="${DB_USER}" --single-transaction --routines --triggers --events "$DB_NAME" | gzip > "$OUT"
gzip -t "$OUT"
echo "Respaldo generado y comprobado: $OUT"
