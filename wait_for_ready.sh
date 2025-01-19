#!/bin/bash

# Variables
COMPOSE_FILE="docker-compose.test.yml"
SERVICE_NAME="test"
LOG_MESSAGE="Container is ready"

RETRY_INTERVAL=5  # Seconds to wait between retries
MAX_RETRIES=12    # Maximum number of retries (e.g., 12 retries for 1-minute timeout)

echo "Waiting for service '$SERVICE_NAME' to be ready..."

# Loop to check logs
for ((i=1; i<=MAX_RETRIES; i++)); do
    if docker-compose -f "$COMPOSE_FILE" logs "$SERVICE_NAME" -n 5 | grep -q "$LOG_MESSAGE"; then
        echo "Service '$SERVICE_NAME' is ready."
        exit 0
    fi
    echo "Attempt $i/$MAX_RETRIES: Service not ready yet, retrying in $RETRY_INTERVAL seconds..."
    sleep $RETRY_INTERVAL
done

echo "Service '$SERVICE_NAME' did not become ready in time."
exit 1