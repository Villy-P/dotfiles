#!/bin/sh
WEBHOOK=$(cat /etc/smartd-discord-webhook)
HOST=$(hostname)

PAYLOAD=$(jq -n \
  --arg title "SMART alert on $HOST: $SMARTD_DEVICE ($SMARTD_FAILTYPE)" \
  --arg desc "$SMARTD_MESSAGE" \
  '{embeds: [{title: $title, description: $desc, color: 15158332}]}')

curl -s -H "Content-Type: application/json" -d "$PAYLOAD" "$WEBHOOK"
