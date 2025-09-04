module starter::practica_sui {
    use std::debug::print;
    use std::string::(String, utf8);

    fun practica() {
    //para probar se usa en consola "sui move test"
    //imprimir texto
        print(&utf8(b"Hello, World!"));

    //para declara constantes
        //const CONSTANTE: u64 = 1;
        
    //declaramiento de variables mutables
        //let mut variable: u8 = 1;  //se pone u8 por que sera un entero de 8 bits (hasta 255)
//esa info esta en el repositorio /backend/ver variables
        let mut variable= 264u16;//es lo mismo de arriba pero con 16 bits
        let mut otra = 300u16; //esta de 8 bits
       // let mut suma = variable + otra; //si yo pongo u8 da error
//no hay numeros flotantes en move
             
        print(&(otra > variable));

    }

    struct Usuario has drop{
        nombre: String;
        edad: u8;
        vivo: bool;
    }

    fun practica2(usuario: Usuario) {
        usuario.edad
        //let mut edad: u8 = 18; para no ponerla arriba
        if(edad > 18){
            print(&utf8(b"Acceso permitido"));
        }else if(edad == 18){
            print(&utf8(b"felicidades"));
        }else{
            print(&utf8(b"Acceso NO permitido"));
        }
    }

    #[test]
    fun prueba() {
        

        practica2(usuario);
    }
}