# 04 · Trazabilidad de un bono

Obtiene la **trazabilidad completa** de un bono: la cadena cronológica de
propietarios y todos los eventos de auditoría. Es el corazón de la promesa de
VELAR — historia verificable y **append-only** (nunca se edita ni se borra).

## Qué muestra

- `owners[]` — cadena de propietarios con `since` / `until` y quién es el actual.
- `events[]` — eventos de auditoría del bono (emisión, transferencias, escrow, pagos…).
- La versión **pública** del endpoint (sin autenticación) para verificación por terceros.

## Endpoints usados

| Método | Ruta | Auth |
|--------|------|------|
| `GET` | `/api/audit/bonds/:tokenId/traceability` | JWT (cualquier rol autenticado) |
| `GET` | `/api/public/bonds/:idOrToken/traceability` | pública |

## Correr

```bash
export SUPABASE_URL="https://<tu-proyecto>.supabase.co"
export SUPABASE_PUBLISHABLE_KEY="<anon/publishable key>"
export API_URL="http://localhost:3001/api"   # opcional
# opcionales:
export DEMO_EMAIL="recomprador@velar.cr"
export DEMO_PASSWORD="Velar12345!"
export BOND_TOKEN_ID="<tokenId>"              # si no, toma el primero disponible

./run.sh
```

Requiere `curl` y `jq`. Si no pasás `BOND_TOKEN_ID`, el script toma el primer
bono disponible en CR.

## Notas

- La cadena de propietarios y los eventos son **append-only**: el historial no se
  reordena ni se modifica.
- Ver las máquinas de estado en
  [`velar-spec`](https://github.com/Velar-Bonds/velar-spec) para interpretar los
  estados de cada evento.
