#!/usr/bin/env bash
set -euo pipefail

NEXTCLOUD_LOCATION=~/homelab/services/nextcloud
DESTINATION_DIR="$NEXTCLOUD_LOCATION"/backups
DATA_DIR="$NEXTCLOUD_LOCATION"/data
mkdir -p "$DESTINATION_DIR"

NEXTCLOUD_ROOT_PASSWORD=$(grep -E '^NEXTCLOUD_ROOT_PASSWORD=' ../.env | cut -d '=' -f2-)

cd "$NEXTCLOUD_LOCATION"

docker compose --env-file ../.env exec app php occ maintenance:mode --on
trap 'docker compose --env-file ../.env exec app php occ maintenance:mode --off' EXIT

docker compose --env-file ../.env exec db mysqldump -u root -p"$NEXTCLOUD_ROOT_PASSWORD" nextcloud > "$DESTINATION_DIR/nextcloud_db_backup.sql"
sudo rsync -a --delete "$DATA_DIR"/nextcloud "$DESTINATION_DIR"/nextcloud_data_backup

echo "Nextcloud backup completed successfully. Backup files are located in $DESTINATION_DIR"

# Restore
# docker compose --env-file ../../.env up -d db
# docker compose --env-file ../../.env exec -T db mysql -u root -p"$NEXTCLOUD_ROOT_PASSWORD" nextcloud < ~/homelab/services/nextcloud/backups/nextcloud_db_backup.sql
# rsync -a ~/homelab/services/nextcloud/backups/nextcloud_data_backup/ ~/homelab/services/nextcloud/data/
# docker compose up -d app
