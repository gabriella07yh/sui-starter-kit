# Guia: Sugerencias de uso para una pequeña semilla

Esta guia se hizo con el objetivo de ayudar a algun usuario nuevo que quisiera probar el proyecto "GreenPoints" sin complicaciones con un paso a paso, usando los comandos de Sui CLI para ello :D

## Antes de empezar necesitas:

- Tener configurado el Sui CLI y tener una wallet con fondos
- Posterior a ello crea el catalogo de actividades y el leaderboard, esto para poder crear los objetos necesarios para que los perfiles puedan registrar actividades y acumular puntos, seguido a eso se crea el perfil y se realizan actividades de prueba

## Notas importantes

- Reemplaza <PACKAGE_ID>, <CATALOG_ID>, <BOARD_ID>, <PROFILE_ID> con los IDs reales de tus objetos
- Cada transaccion requiere gas, asegurate de tener suficientes fondos
- Los objetos se crean una sola vez y se reutilizan
- Puedes registrar multiples actividades en transacciones separadas

## Flujo de uso recomendado

```bash

# 1.- Crear objetos base del sistema

    # 1.1.- Crear catalogo con actividades ecologicas
    sui client call --package <PACKAGE_ID> --module green_points --function create_catalog --gas-budget 10000000

    # 1.2.- Crear leaderboard vacio
    sui client call --package <PACKAGE_ID> --module green_points --function create_board --gas-budget 10000000

# 2.- Crear tu perfil de usuario
sui client call --package <PACKAGE_ID> --module green_points --function create_profile --gas-budget 10000000

# 3.- Consultar actividades disponibles
sui client call --package <PACKAGE_ID> --module green_points --function list_activities --args <CATALOG_ID> --gas-budget 10000000

# 4.- Registrar primera actividad: Plantar arbol (ID 1)
sui client call --package <PACKAGE_ID> --module green_points --function do_activity --args <PROFILE_ID> <CATALOG_ID> <BOARD_ID> 1 --gas-budget 10000000

# 5.- Consultar tu perfil actualizado
sui client call --package <PACKAGE_ID> --module green_points --function get_profile --args <PROFILE_ID> --gas-budget 10000000

# 6.- Registrar mas actividades para subir de rango

    # 6.1.- Reciclar (ID 2)
    sui client call --package <PACKAGE_ID> --module green_points --function do_activity --args <PROFILE_ID> <CATALOG_ID> <BOARD_ID> 2 --gas-budget 10000000

    # 6.2.- Usar bicicleta (ID 3)  
    sui client call --package <PACKAGE_ID> --module green_points --function do_activity --args <PROFILE_ID> <CATALOG_ID> <BOARD_ID> 3 --gas-budget 10000000

# 7.- Consultar leaderboard para comparar con otros usuarios
sui client call --package <PACKAGE_ID> --module green_points --function get_score --args <BOARD_ID> <DIRECCION_USUARIO> --gas-budget 10000000