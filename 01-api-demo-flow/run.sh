#!/usr/bin/env bash
# Demo mínimo: login + listar bonos disponibles
set -euo pipefail

API="${API_URL:-http://localhost:3001/api}"
SUPA="${SUPABASE_URL:?Set SUPABASE_URL}"
ANON="${SUPABASE_PUBLISHABLE_KEY:?Set SUPABASE_PUBLISHABLE_KEY}"
EMAIL="${DEMO_EMAIL:-recomprador@velar.cr}"
PASS="${DEMO_PASSWORD:-Velar12345!}"

echo "→ Login $EMAIL"
TOKEN=$(curl -s "$SUPA/auth/v1/token?grant_type=password" \
  -H "apikey: $ANON" -H "Content-Type: application/json" \
  -d "{\"email\":\"$EMAIL\",\"password\":\"$PASS\"}" | jq -r '.access_token')

if [[ "$TOKEN" == "null" || -z "$TOKEN" ]]; then
  echo "❌ Login falló. Revisá credenciales y Supabase."
  exit 1
fi

echo "→ Bonos disponibles (CR)"
curl -s "$API/bonds/available?country=CR" \
  -H "Authorization: Bearer $TOKEN" | jq '.[0:3]'

echo ""
echo "✓ OK. Para ofertar: POST $API/transfers { bondTokenId, amount, paymentMethod }"
