
/* ----- Armas Peligrosas ----- */

/*
Integrante 1

El báculo otorga como máximo 400 unidades de poder. 
Se calcula con un poder base de 250 que se duplica si el guerrero que lo utiliza tiene poca vida. 
El poder base puede cambiar a lo largo del tiempo.

*/
object baculo {
    var poderBase  = 250 

    method tienePocaVida(guerrero) {
        return guerrero.vidaGuerrero() < 10
    }

    // A quien le interesa mas saber o tener la responsabilidad de ver si tiene poca vida, el arma o el guerrero ?
    // Quien debe ser dueño de ese metoodo ?

    /*
        method poderPotenciado(unGuerrero) {
            if(unGuerrero.tienePocaVida())
                return poderBase*2
            else 
                return poderBase
        }
    */
    method poderPotenciado(unGuerrero) {
        if(self.tienePocaVida(unGuerrero))
            return poderBase*2
        else 
            return poderBase
    }

    method poderBase(nuevoPoder) {
        poderBase = nuevoPoder
    }

    method poder(unGuerrero) {
        return 400.min(self.poderPotenciado(unGuerrero))
    }
}

/*
Integrante 2

En el caso de la espada, el poder que otorga es de 10 veces por el valor dado por la magia que la rige. 
Su espada (muy parecida a Glamdring)  en el mundo de objetos es un poco influenciable y puede cambiar la 
magia que la afecta. 
Inicialmente es magia élfica y vale 25 siempre. Si fuera enana, 
es la mitad de la vida que tiene el mago que la utiliza.

*/

object magiaElfica{
    method valorMagico(unGuerrero) {
        return 25
    }
}
object magiaEnana{
    method valorMagico(unGuerrero) {
        return unGuerrero.vidaGuerrero()/2
    }
}

object espada
{
    var magia = magiaElfica

    method magia(nuevaMagia) {
        magia = nuevaMagia
    }
    
    method poder(unGuerrero) {
        return 10 * magia.valorMagico(unGuerrero)
    }

}

/*
Integrante 3

La flecha de bronce otorga inicialmente 100 puntos pero depende de cuánto tiempo lleva lustrada. 
Este tipo de flecha se lustra en una fecha en particular y resta un punto por cada día que pasa luego de lustrar hasta llegar a 0. 
Por ejemplo si se lustra el 01/01/2024 y se usa el 05/01/2024, suma 96 puntos.

*/

object flechaBronce
{
    var fechaLustrado = new Date(day = 1, month = 1, year = 2026)
    var fechaUso = new Date(day = 5, month = 1, year = 2026)

    method fechaLustrado(nuevaFecha) {
        fechaLustrado = nuevaFecha
    }

    method fechaUso(nuevaFecha) {
        fechaUso = nuevaFecha
    }

    method poderLustrado() {
        const diasPasados = fechaUso - fechaLustrado
        return 100 - diasPasados
    }

    method poderFlecha()
    {
        return 0.max(self.poderLustrado())
    }
}

/*

La flecha de aluminio tiene un valor de 50 y puede variar con el tiempo.

*/
object flechaAluminio
{
    var poderActual = 50

    method modificarPoder(nuevoValor)
    {
        poderActual = nuevoValor
    }

    method poderFlecha()
    {
        return poderActual
    }
}

/*

La flecha de hierro otorga 70 puntos pero si están oxidadas su valor se reduce en un 50%.

*/

object flechaHierro
{
    const poderActual = 70
    var oxidada = true

    method sacarOxido()
    {
        oxidada = false
    }

    method oxidar()
    {
        oxidada = true
    }

    method poderFlecha()
    {
        if(oxidada)
        {
            return poderActual / 2
        }
        
        return poderActual
    }
}

/*

Además necesitamos modelar la caja de flechas negras que tiene una cantidad disponible para poder lanzar. 
Posee tres flechas y cada una tiene su valor particular dependiendo de la materialidad con la que se construyó.

La caja otorga el promedio de las flechas de más de 50 puntos, porque el resto resulta insignificante. 

*/
object cajaFlechasNegras
{
    const flechasDisponibles = [flechaAluminio, flechaHierro, flechaBronce]

    method calcularPoderFlecha(flecha)
    {

        return flecha.poderFlecha()
            
    }

    method poderPromedio()
    {
        return flechasDisponibles.filter({flecha => self.calcularPoderFlecha(flecha) > 50}).average({flecha => self.calcularPoderFlecha(flecha)})
    }

    method poder(unGuerrero)
    {
        return self.poderPromedio()

    }
}

/* ----- Guerreros ----- */

/*

Uno de ellos es Gandalf “El Gris”, como se lo conoce normalmente (porque tiene varios nombres, 
varían dependiendo a quien se le pregunte). 
Gandalf tiene un nivel de vida que es en principio de 100.
Lleva consigo ciertas armas, como su báculo, su espada (muy parecida a Glamdring) y una caja de flechas negras.

Su poder se calcula como: cantidad de vida * 15 + Sumatoria del Poder de sus Armas * 2 
pero en el caso de que tenga poca vida (es decir que su nivel de vida sea menor a 10), 
la fórmula cambia de la siguiente manera: cantidad de vida * 200 + Sumatoria del Poder de sus Armas * 2


*/
object gandalf
{
    var property nombre  = "Gandalf el Gris"
    var property vidaGuerrero = 100
    const armasGuerrero = [baculo, espada, cajaFlechasNegras]

    method armasGuerrero() {
        return armasGuerrero
    }

    method tamanioArsenal() {
       return armasGuerrero.size()
    }

    method poderArmas()
    {
        return armasGuerrero.sum({arma => arma.poder(self)})
    }

    method poder()
    {   
        if (self.vidaGuerrero() < 10)
        {
            return (vidaGuerrero * 200) + (self.poderArmas() * 2)
        }

        return (vidaGuerrero * 15) + (self.poderArmas() * 2)
    }

    method sacarVida(unValor) {
        vidaGuerrero = 0.max(vidaGuerrero - unValor)
    }

    method aumentarVida(unValor) {
        vidaGuerrero = vidaGuerrero + unValor
    }

    method recorrerCamino(caminoDeGondor) {
        if(caminoDeGondor.puedeRecorrerCamino(self))
        {
            caminoDeGondor.realizarCamino(self)
        }
    }

}

/* ----- Zonas de la Tierra Media ----- */
object lebennin {
    var property guardias = 3

    method puedePasar(unGuerrero) {
        if(guardias > 3)
        {
            return unGuerrero.poder() > 1500
        }
        else
        {
            return unGuerrero.poder() > 1000
        }
            
    }

    method pasarPorAca(unGuerrero) {
        if(self.puedePasar(unGuerrero))
        {
            unGuerrero.sacarVida(0)
        }
    }      
}

object minasTirith {
    method puedePasar(unGuerrero) {
        return unGuerrero.tamanioArsenal() > 0
    }

    method pasarPorAca(unGuerrero) {
        if(self.puedePasar(unGuerrero))
        {
            unGuerrero.sacarVida(10*unGuerrero.tamanioArsenal())
        }
            
    }      
}

object lossarnach {
    method puedePasar(unGuerrero) {
        return true
    }

    method pasarPorAca(unGuerrero) {
        if(self.puedePasar(unGuerrero))
        {
            unGuerrero.aumentarVida(2*unGuerrero.tamanioArsenal())
        }
            
    }      
}

object caminoDeGondor {
    var property lugares = [lebennin, minasTirith]

    method puedeRecorrerCamino(unGuerrero) {
        return lugares.all({lugar => lugar.puedePasar(unGuerrero)})
    }

    method realizarCamino(unGuerrero) {
        return lugares.forEach({lugar => lugar.pasarPorAca(unGuerrero)})
    }
}

/* ----- Tom Bombadil ----- */
object tomBombadil
{
    const vidaGuerrero = 2000

    method vidaGuerrero() {
        return vidaGuerrero
    }

    method tamanioArsenal() {
        return 100
    }

    method poder() {
        return 2000
    }

    method sacarVida(unValor) {
    } // No pierde vida, es inmortal.
}