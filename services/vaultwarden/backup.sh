#!/usr/bin/env bash
set -euo pipefail

VAULTWARDEN_LOCATION=~/homelab/services/vaultwarden
DESTINATION_DIR="$VAULTWARDEN_LOCATION"/backups
DATA_DIR="$VAULTWARDEN_LOCATION"/data
mkdir -p "$DESTINATION_DIR"

sqlite3 "$DATA_DIR/db.sqlite3" ".backup '$DESTINATION_DIR/db_backup.sqlite3'"
sqlite3 "$DESTINATION_DIR/db_backup.sqlite3" "PRAGMA integrity_check;" | grep -q "^ok$" \
  || { echo "Backup integrity check FAILED" >&2; exit 1; }
cp "$DATA_DIR"/rsa_key* "$DESTINATION_DIR/" 2>/dev/null || true

echo "Vaultwarden backup completed successfully. Backup files are located in $DESTINATION_DIR"