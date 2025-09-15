# Proyecto: GreenPoints - Registro de huella ecologica en Sui

Documentacion del backend de move que registra actividades ecologicas, acumula puntos y asigna un rango/nivel con titulo y frase motivadora para incentivar al usuario
El registro de Huella ecologica es un proyecto deasrrollado en Move sobre la blockchain de Sui, cuyo objetivo pricipal es promover acciones sostenibles mediante un sistema de puntos llamado GreenPoints, este consiste en dar cierta candidad de puntos dependiendo de alguna actividad ecologica realizada, a su vez con estos puntps obtienen un nivel/rango, un titulo y una frase motivadora (dependiendo de la cantidad de puntos obtenidos).

## Actividades

--------------------------------------------
| ID | Actividad                  | Puntos |
|----|----------------------------|--------|
| 1  | Plantar arbol              | 60     |
| 2  | Reciclar                   | 40     |
| 3  | Usar bicicleta             | 30     |
| 4  | Ahorrar agua               | 10     |
| 5  | Reducir electricidad       | 20     |
| 6  | Voluntariado ambiental     | 70     |
| 7  | Limpiar espacios publicos  | 50     |
--------------------------------------------

## Rangos, titulos y frases

-------------------------------------------------------------------------------------------------------------------------
| Rango      | Puntos        | Titulo                  | Frase motivadora                                               |
|------------|---------------|-------------------------|----------------------------------------------------------------|
| Cobre      | 0 – 99        | Semillita Exploradora   | comienza tu camino hacia la sostenibilidad ambiental           |
| Plata      | 100 – 299     | Hoja Renovadora         | cada granito importa! contribuye mas al bienestar del planeta  |
| Oro        | 300 – 599     | Raiz Protectora         | tus esfuerzos fortalecen la vida de la naturaleza              |
| Platino    | 600 – 999     | Guardabosques           | Continua defendiendo los ecosistemas y su equilibrio           |
| Diamante   | 1000 – 1299   | Guardian de la Tierra   | tus acciones inican el cambio, el ecosistema te necesita       |
| Zafiro     | 1300 – 1699   | Protector de Rios       | promueves la salud y pureza del agua en el mundo, no te rindas |
| Legendario | 1700+         | Heroe Verde             | eres la inspiracion y liderazgo que el planeta necesita        |
-------------------------------------------------------------------------------------------------------------------------

## Funciones principales

- `create_catalog(ctx)` → Crea el catalogo con actividades ecologicas predefinidas
- `create_board(ctx)` → Crea el leaderboard inicial vacio  
- `create_profile(user, ctx)` → Crea un perfil nuevo con 0 puntos y rango "Cobre"
- `do_activity(profile, catalog, board, activity_id)` → Registra actividad y actualiza puntos
- `get_profile(profile)` → Devuelve (puntos, rango, titulo, frase motivadora)
- `list_activities(catalog)` → Lista todas las actividades disponibles
- `get_score(board, address)` → Consulta puntos de usuario en el leaderboard

## Compilar y publicar

```bash
# complilar el paquete
sui move build

# publicar en testnet
sui client publish --gas-budget 30000000

# publicar en mainnet
sui client publish --gas-budget 30000000 --network mainnet
