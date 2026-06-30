<div align="center">

# VELAR · Examples

### Ejemplos ejecutables para integrar con la plataforma

[![Stellar](https://img.shields.io/badge/Stellar-testnet-7D00FF?logo=stellar&logoColor=white)](https://stellar.org)
[![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?logo=typescript&logoColor=white)](https://www.typescriptlang.org)

Código mínimo y copy-paste para developers, demos TSE y hackathons.

[Spec](../velar-spec) · [Docs](../velar-docs) · [App](../Velar)

</div>

---

## Ejemplos

| Carpeta | Qué demuestra |
|---------|---------------|
| [`01-api-demo-flow/`](./01-api-demo-flow/) | Flujo completo vía REST (login → oferta → accept) con `curl` |
| [`02-wallet-payment/`](./02-wallet-payment/) | Negociación + pago USDC con Freighter (build-xdr → sign → submit) |
| [`03-verify-audit/`](./03-verify-audit/) | Consultar eventos de auditoría y enlazar a Stellar Expert |

---

## Requisitos

- API corriendo (`Velar`: `npm run dev` o `https://velar-api.vercel.app/api`)
- Cuentas demo o propias en Supabase
- Para wallet: [Freighter](https://www.freighter.app/) en **testnet**

Variables comunes (ver [velar-docs · Environment](https://github.com/Velar-Bonds/velar-docs/blob/main/docs/09-environment.md)):

```bash
export API_URL=https://velar-api.vercel.app/api
export SUPABASE_URL=https://your-project.supabase.co
export SUPABASE_PUBLISHABLE_KEY=your-anon-key
```

---

## Orden sugerido

1. **01-api-demo-flow** — entender roles y estados sin blockchain  
2. **03-verify-audit** — trazabilidad pública  
3. **02-wallet-payment** — DvP on-chain (requiere migraciones + wallets provisionadas)

---

## Licencia

MIT — mismo espíritu que [Velar](https://github.com/Velar-Bonds/Velar).
