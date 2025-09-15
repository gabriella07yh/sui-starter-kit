#[allow(duplicate_alias)]
module starter::green_points {

    use sui::object;
    use sui::tx_context;
    use sui::table;
    use std::vector;

    public struct Activity has store, copy, drop {
        id: u64,
        name: vector<u8>,
        points: u64,
    }

    public struct Catalog has key {
        id: UID,
        list: table::Table<u64, Activity>,
    }

    public struct Profile has key {
        id: UID,
        owner: address,
        points: u64,
        rank: vector<u8>,
    }

    public struct Board has key {
        id: UID,
        scores: table::Table<address, u64>,
    }

    /// crea un catalogo de actividades ambientales con sus puntos correspondientes
    public fun create_catalog(ctx: &mut tx_context::TxContext): Catalog {
        let mut t = table::new<u64, Activity>(ctx);

        table::add(&mut t, 1, Activity { id: 1, name: b"Plantar arbol", points: 60 });
        table::add(&mut t, 2, Activity { id: 2, name: b"Reciclar", points: 40 });
        table::add(&mut t, 3, Activity { id: 3, name: b"Usar bicicleta", points: 30 });
        table::add(&mut t, 4, Activity { id: 4, name: b"Ahorrar agua", points: 10 });
        table::add(&mut t, 5, Activity { id: 5, name: b"Reducir electricidad", points: 20 });
        table::add(&mut t, 6, Activity { id: 6, name: b"Voluntariado ambiental", points: 70 });
        table::add(&mut t, 7, Activity { id: 7, name: b"Limpiar espacios publicos", points: 50 });

        Catalog { id: object::new(ctx), list: t }
    }

    /// crea un tablero para llevar el registro de puntuaciones
    public fun create_board(ctx: &mut tx_context::TxContext): Board {
        Board { id: object::new(ctx), scores: table::new<address, u64>(ctx) }
    }

    /// crea un perfil para un usuario con puntos iniciales en 0 y rango "Cobre" (mas bajo)
    public fun create_profile(_user: &signer, ctx: &mut tx_context::TxContext): Profile {
        Profile {
            id: object::new(ctx),
            owner: tx_context::sender(ctx),
            points: 0,
            rank: b"Cobre",
        }
    }

    /// realiza una actividad y actualiiza los puntos del perfil y el tablero
    public fun do_activity(profile: &mut Profile, catalog: &Catalog, board: &mut Board, activity_id: u64) {
        let act = table::borrow(&catalog.list, activity_id);
        let new_points = profile.points + act.points;
        profile.points = new_points;
        profile.rank = rank_for_points(new_points);

        if (table::contains(&board.scores, profile.owner)) {
            let sc = table::borrow_mut(&mut board.scores, profile.owner);
            *sc = *sc + act.points;
        } else {
            table::add(&mut board.scores, profile.owner, act.points);
        };
    }

    /// determina el rango basado en los puntos acumulados
    fun rank_for_points(p: u64): vector<u8> {
        if (p < 100) {
            b"Cobre"
        } else if (p < 300) {
            b"Plata"
        } else if (p < 600) {
            b"Oro"
        } else if (p < 1000) {
            b"Platino"
        } else if (p < 1300) {
            b"Diamante"
        } else if (p < 1700) {
            b"Zafiro"
        } else {
            b"Legendario"
        }
    }

    /// obtine el titulo basado en los puntos
    fun title_for_points(p: u64): vector<u8> {
        if (p < 100) {
            b"Semillita Exploradora"
        } else if (p < 300) {
            b"Hoja Renovadora"
        } else if (p < 600) {
            b"Raiz Protectora"
        } else if (p < 1000) {
            b"Guardabosques"
        } else if (p < 1300) {
            b"Guardian de la Tierra"
        } else if (p < 1700) {
            b"Protector de los Rios"
        } else {
            b"Heroe Verde"
        }
    }

    /// obtiene una frase motivacional basada en los puntos
    fun phrase_for_points(p: u64): vector<u8> {
        if (p < 100) {
            b"comienza tu camino hacia la sostenibilidad ambiental"
        } else if (p < 300) {
            b"cada granito importa! contribuye mas al bienestar del planeta"
        } else if (p < 600) {
            b"Tus esfuerzos fortalecen la vida de la naturaleza"
        } else if (p < 1000) {
            b"Continua defendiendo los ecosistemas y su equilibrio"
        } else if (p < 1300) {
            b"tus acciones inican el cambio, el ecosistema te necesita"
        } else if (p < 1700) {
            b"promueves la salud y pureza del agua en el mundo, no te rindas"
        } else {
            b"eres la inspiracion y liderazgo que el planeta necesita"
        }
    }

    // btiene informacion completa del perfil: puntos, rango, titulo y frase motivadora
    public fun get_profile(profile: &Profile): (u64, vector<u8>, vector<u8>, vector<u8>) {
        let points = profile.points;
        (
            points,
            profile.rank,
            title_for_points(points),
            phrase_for_points(points)
        )
    }

    // lista todas las actividades dispnibles en el catalogo
    public fun list_activities(catalog: &Catalog): vector<Activity> {
        let mut acts: vector<Activity> = vector::empty();
        let mut i = 1;
        while (i <= 7) {
            let a = table::borrow(&catalog.list, i);
            vector::push_back(&mut acts, *a);
            i = i + 1;
        };
        acts
    }

    // obtiene el puntaje de un usuario ESPECIFICO del tablero
    public fun get_score(board: &Board, who: address): u64 {
        if (table::contains(&board.scores, who)) {
            *table::borrow(&board.scores, who)
        } else {
            0
        }
    }
}