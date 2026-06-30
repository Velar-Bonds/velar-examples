# 03 · Verificar auditoría

Consulta el registro append-only de eventos.

```bash
export API_URL=http://localhost:3001/api
export TSE_JWT=...   # login como tse@velar.cr

# Eventos recientes (requiere rol TSE o endpoint público según deploy)
curl -s "$API_URL/audit?page=1&limit=20" \
  -H "Authorization: Bearer $TSE_JWT" | jq .

# Explorer público en la web
open "https://velar-web.vercel.app/explorer"
```

Cada evento con `txHash` se puede abrir en Stellar Expert testnet:

```
https://stellar.expert/explorer/testnet/tx/{txHash}
```
