# 02 · Pago con wallet (negociación + DvP)

Flujo **post-aceptación** con USDC en Stellar testnet.

## Prerrequisitos

- [ ] Migraciones Supabase aplicadas (`payment_method`, `payment_methods`, `stellar_public_key`)
- [ ] Comprador: Freighter testnet + `PATCH /users/me/wallet` con su `G...`
- [ ] Vendedor: wallet custodial con el bono (`STELLAR_WALLETS_JSON` en API)
- [ ] Bono publicado con método `wallet`

## Secuencia

```bash
# 1. Oferta (comprador)
curl -X POST "$API_URL/transfers" \
  -H "Authorization: Bearer $BUYER_JWT" \
  -H "Content-Type: application/json" \
  -d '{"bondTokenId":"UUID","amount":950000,"paymentMethod":"wallet"}'

# 2. Aceptar (vendedor)
curl -X PATCH "$API_URL/transfers/$TRANSFER_ID/accept" \
  -H "Authorization: Bearer $SELLER_JWT"

# 3. Build XDR (comprador)
curl -X POST "$API_URL/transfers/$TRANSFER_ID/build-wallet-payment-xdr" \
  -H "Authorization: Bearer $BUYER_JWT" | jq .

# 4. Firmar xdr con Freighter (browser o @stellar/freighter-api)

# 5. Submit (comprador)
curl -X POST "$API_URL/transfers/$TRANSFER_ID/submit-wallet-payment-xdr" \
  -H "Authorization: Bearer $BUYER_JWT" \
  -H "Content-Type: application/json" \
  -d '{"signedXdr":"AAAA..."}'
```

## Troubleshooting

| Error | Causa probable |
|-------|----------------|
| Botón no aparece en UI | `payment_method` null → migración faltante |
| `No hay llave en custodia` | Vendedor usa Freighter pero DvP necesita co-firma custodial |
| `Conectá y vinculá tu wallet` | Falta `PATCH /users/me/wallet` |

Ver [Velar · HANDOFF-PAGO-WALLET](https://github.com/Velar-Bonds/Velar/blob/main/docs/HANDOFF-PAGO-WALLET.md).
