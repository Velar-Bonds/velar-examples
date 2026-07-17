#!/usr/bin/env bash
# Demo: trazabilidad completa de un bono (cadena de propietarios + eventos de auditoría)
set -euo pipefail

API="${API_URL:-http://localhost:3001/api}"
SUPA="${SUPABASE_URL:?Set SUPABASE_URL}"
ANON="${SUPABASE_PUBLISHABLE_KEY:?Set SUPABASE_PUBLISHABLE_KEY}"
EMAIL="${DEMO_EMAIL:-recomprador@velar.cr}"
PASS="${DEMO_PASSWORD:-Velar12345!}"
TOKEN_ID="${BOND_TOKEN_ID:-}"

echo "→ Login $EMAIL"
JWT=$(curl -s "$SUPA/auth/v1/token?grant_type=password" \
  -H "apikey: $ANON" -H "Content-Type: application/json" \
  -d "{\"email\":\"$EMAIL\",\"password\":\"$PASS\"}" | jq -r '.access_token')

if [[ "$JWT" == "null" || -z "$JWT" ]]; then
  echo "❌ Login falló. Revisá credenciales y Supabase."
  exit 1
fi

# Si no se pasó BOND_TOKEN_ID, tomamos el primer bono disponible.
if [[ -z "$TOKEN_ID" ]]; then
  echo "→ Buscando un bono para trazar…"
  TOKEN_ID=$(curl -s "$API/bonds/available?country=CR" \
    -H "Authorization: Bearer $JWT" | jq -r '.[0].tokenId // empty')
fi

if [[ -z "$TOKEN_ID" ]]; then
  echo "❌ No hay bonos disponibles. Seteá BOND_TOKEN_ID manualmente."
  exit 1
fi

echo "→ Trazabilidad del bono $TOKEN_ID (autenticado)"
curl -s "$API/audit/bonds/$TOKEN_ID/traceability" \
  -H "Authorization: Bearer $JWT" | jq '{
    bond: .bond.tokenId,
    status: .bond.status,
    owners: [.owners[] | {name, since, until, current}],
    eventos: [.events[] | {type, createdAt}]
  }'

echo ""
echo "→ La misma trazabilidad, pública (sin auth):"
echo "  GET $API/public/bonds/$TOKEN_ID/traceability"
curl -s "$API/public/bonds/$TOKEN_ID/traceability" | jq '.bond.tokenId, (.events | length)'

echo ""
echo "✓ OK. La cadena de propietarios y los eventos son append-only (nunca se editan)."
