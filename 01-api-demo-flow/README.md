# 01 · Demo flow vía API

Replica el flujo de negociación P2P usando solo HTTP.

## Variables

```bash
export API_URL=http://localhost:3001/api
export SUPABASE_URL=https://your-project.supabase.co
export SUPABASE_PUBLISHABLE_KEY=your-anon-key
export DEMO_EMAIL=recomprador@velar.cr
export DEMO_PASSWORD=Velar12345!
```

## Ejecutar

```bash
chmod +x run.sh
./run.sh
```

O usar el script oficial del monorepo:

```bash
cd ../Velar && npm run demo:flow
```

## Pasos que cubre

1. Login Supabase → JWT  
2. Listar bonos en venta  
3. `POST /transfers` (oferta)  
4. Vendedor `PATCH /transfers/:id/accept`  
5. Comprador `PATCH /transfers/:id/payment`  
6. Vendedor `PATCH /transfers/:id/release`
