set -euo pipefail

URL="${1:?Usage: $0 <healthcheck-url>}"
MAX_RETRIES=15
SLEEP_SECONDS=2

echo "Checking health at $URL..."
for i in $(seq 1 "$MAX_RETRIES"); do
  if curl -sf "$URL" > /dev/null; then
    echo "Healthcheck passed on attempt $i!"
    exit 0
  fi
  echo "Attempt $i/$MAX_RETRIES failed, retrying in ${SLEEP_SECONDS}s..."
  sleep "$SLEEP_SECONDS"
done

echo "Healthcheck failed after $MAX_RETRIES attempts."
exit 1
