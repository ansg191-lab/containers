#!/bin/bash
set -euo pipefail

# Check required environment variables
if [ -z "${QBT_IP:-}" ]; then
	echo "Error: QBT_IP environment variable is not set."
	exit 1
fi

if [ -z "${QBT_PORT:-}" ]; then
	echo "Error: QBT_PORT environment variable is not set."
	exit 1
fi

if [ -z "${DISCORD_WEBHOOK_URL:-}" ]; then
	echo "Error: DISCORD_WEBHOOK_URL environment variable is not set."
	exit 1
fi

CHECK_INTERVAL=${CHECK_INTERVAL:-60}

# Discord embed colors (decimal representation of hex color codes)
COLOR_GREEN=65280   # 0x00FF00
COLOR_RED=16711680  # 0xFF0000

send_discord() {
	local color="$1"
	local title="$2"
	local description="$3"

	local payload
	payload=$(jq -n --arg title "$title" --arg description "$description" --argjson color "$color" \
		'{"embeds":[{"title":$title,"description":$description,"color":$color}]}')

	local response http_code body
	response=$(curl -s -w "\n%{http_code}" --connect-timeout 10 --max-time 30 \
		-X POST "$DISCORD_WEBHOOK_URL" \
		-H "Content-Type: application/json" \
		-d "$payload" 2>&1) || true
	http_code=$(tail -n1 <<< "$response")
	body=$(head -n-1 <<< "$response")

	if [[ "$http_code" != 2* ]]; then
		echo "Warning: Discord webhook returned HTTP $http_code: $body"
	fi
}

STATE="unknown"

while true; do
	if nc -z -w 5 "$QBT_IP" "$QBT_PORT" 2>/dev/null; then
		echo "Connection to $QBT_IP:$QBT_PORT successful."
		if [ "$STATE" = "down" ]; then
			echo "State changed: down -> up. Sending recovery notification."
			send_discord $COLOR_GREEN "qbt-conntest: Recovered" "Connection to $QBT_IP:$QBT_PORT restored."
		fi
		STATE="up"
	else
		echo "Unable to connect to $QBT_IP:$QBT_PORT."
		if [ "$STATE" = "up" ]; then
			echo "State changed: $STATE -> down. Sending failure notification."
			send_discord $COLOR_RED "qbt-conntest: Connection Failed" "Unable to connect to $QBT_IP:$QBT_PORT."
		fi
		STATE="down"
	fi

	sleep "$CHECK_INTERVAL"
done
