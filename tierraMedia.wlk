
/* ENTREGA 1 */

/*
Integrante 1

El báculo otorga como máximo 400 unidades de poder. 
Se calcula con un poder base de 250 que se duplica si el guerrero que lo utiliza tiene poca vida. 
El poder base puede cambiar a lo largo del tiempo.
*/
class Baculo 
{
    
    var poderBase  = 250 

    method poderBase(nuevoPoder) 
    {
        poderBase = nuevoPoder
    }

    method poderPotenciado(unGuerrero) 
    {
        if(unGuerrero.vida() <= 10 )
            return poderBase*2
        else 
            return poderBase
    }

    method poder(unGuerrero) 
    {
        return 400.min(self.poderPotenciado(unGuerrero))
    }
}

/*
Integrante 2

En el caso de la espada, el poder que otorga es de 10 veces por el valor dado por la magia que la rige. 
Su espada (muy parecida a Glamdring)  en el mundo de objetos es un poco influenciable y puede cambiar la magia que la afecta. 
Inicialmente es magia élfica y vale 25 siempre. Si fuera enana, es la mitad de la vida que tiene el mago que la utiliza.
*/
object magiaElfica
{
    method valorMagico(unGuerrero)
    {
        return 25
    }
}

object magiaEnana
{
    method valorMagico(unGuerrero)
    {
        return unGuerrero.vidaGuerrero()/2
    }
}

/*class Espada
{
    var magia 

    method magia(nuevaMagia) 
    {
        magia = nuevaMagia
    }
    
    method poder(unGuerrero)
    {
        return 10 * magia.valorMagico(unGuerrero)
    }

}*/

/*
Integrante 3

La flecha de bronce otorga inicialmente 100 puntos pero depende de cuánto tiempo lleva lustrada.
Este tipo de flecha se lustra en una fecha en particular y resta un punto por cada día que pasa luego de lustrar hasta llegar a 0. 
Por ejemplo si se lustra el 01/01/2024 y se usa el 05/01/2024, suma 96 puntos.
*/
class FlechaBronce
{
    var fechaLustrado = new Date(day = 1, month = 1, year = 2026)
    var fechaUso = new Date(day = 1, month = 1, year = 2026)

    method fechaLustrado(nuevaFecha) 
    {
        fechaLustrado = nuevaFecha
    }

    method fechaUso(nuevaFecha) 
    {
        fechaUso = nuevaFecha
    }

    method poderLustrado() 
    {
        const diasPasados = fechaUso - fechaLustrado
        return 100 - diasPasados
    }

    method poderFlecha()
    {
        return 0.max(self.poderLustrado())
    }
}

/*
Gandalf

Existen diversos guerreros que pueden estar vagando por la Tierra Media, portando el anillo por ahí, como si nada estuviera pasando.
Uno de ellos es Gandalf “El Gris”, como se lo conoce normalmente (porque tiene varios nombres, varían dependiendo a quien se le pregunte). 
Gandalf tiene un nivel de vida que es en principio de 100.
Lleva consigo ciertas armas, como su báculo, su espada (muy parecida a Glamdring) y una caja de flechas negras.

Su poder se calcula como: cantidad de vida * 15 + Sumatoria del Poder de sus Armas * 2 pero en el caso de que tenga poca vida (es decir que su nivel de vida sea menor a 10), 
la fórmula cambia de la siguiente manera: cantidad de vida * 200 + Sumatoria del Poder de sus Armas * 2

*/
/*class Guerrero
{
    var property vidaGuerrero
    const armasGuerrero = []
    const poderBase

    method agregarArma (arma)
    {
        armasGuerrero.add(arma)
    }

    method armasGuerrero() 
    {
        return armasGuerrero
    }

    method tamanioArsenal() 
    {
       return armasGuerrero.size()
    }

    method poderArmas()
    {
        return armasGuerrero.sum({arma => arma.poder(self)})
    }

    method poder() = poderBase

    method sacarVida(unValor) 
    {
        vidaGuerrero = 0.max(vidaGuerrero - unValor)
    }

    method aumentarVida(unValor) 
    {
        vidaGuerrero = vidaGuerrero + unValor
    }

    method recorrerCamino(caminoDeGondor) 
    {
        if(caminoDeGondor.puedeRecorrerCamino(self))
        {
            caminoDeGondor.realizarCamino(self)
        }
    }
}*/

/*object gandalf
{
    var property nombre  = "Gandalf el Gris"
    var property vidaGuerrero = 100
    const armasGuerrero = [new Baculo(), new Espada(magia = magiaElfica), new CajaFlechasNegras(flechasDisponibles = [new FlechaAluminio(), new FlechaHierro(), new FlechaBronce()])]

    method agregarArma (arma)
    {
        armasGuerrero.add(arma)
    }

    method armasGuerrero() 
    {
        return armasGuerrero
    }

    method tamanioArsenal() 
    {
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

    method sacarVida(unValor) 
    {
        vidaGuerrero = 0.max(vidaGuerrero - unValor)
    }

    method aumentarVida(unValor) 
    {
        vidaGuerrero = vidaGuerrero + unValor
    }

    method recorrerCamino(caminoDeGondor) 
    {
        if(caminoDeGondor.puedeRecorrerCamino(self))
        {
            caminoDeGondor.realizarCamino(self)
        }
    }

}*/

/*
Integrante 4

Además necesitamos modelar la caja de flechas negras que tiene una cantidad disponible para poder lanzar. 
Posee tres flechas y cada una tiene su valor particular dependiendo de la materialidad con la que se construyó.

-La flecha de aluminio tiene un valor de 50 y puede variar con el tiempo.
-La flecha de hierro otorga 70 puntos pero si están oxidadas su valor se reduce en un 50%.
-la flecha de bronce anteriormente modelada.

La caja otorga el promedio de las flechas de más de 50 puntos, 
porque el resto resulta insignificante
*/
class FlechaAluminio
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

class FlechaHierro
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

/*class FlechaBronce
{
    var fechaLustrado = new Date(day = 1, month = 1, year = 2026)
    var fechaUso = new Date(day = 1, month = 1, year = 2026)

    method fechaLustrado(nuevaFecha) 
    {
        fechaLustrado = nuevaFecha
    }

    method fechaUso(nuevaFecha) 
    {
        fechaUso = nuevaFecha
    }

    method poderLustrado() 
    {
        const diasPasados = fechaUso - fechaLustrado
        return 100 - diasPasados
    }

    method poderFlecha()
    {
        return 0.max(self.poderLustrado())
    }
}*/

class CajaFlechasNegras
{
    const flechasDisponibles = []

    method agregarFlecha(flecha)
    {
        if(flechasDisponibles.size() <= 3)
        {
            flechasDisponibles.add(flecha)
        }
        else
        {
            throw new DomainException(message= "No hay espacio suficiente en la caja")
        }
  
    }

    method sacarFlecha(flecha)
    {
        flechasDisponibles.remove(flecha)
    }
    
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

/* ----- Zonas de la Tierra Media ----- */

/*
Integrante 1

Lebennin es una zona de la Tierra Media con guardias. Aquí solo se permite pasar por ella a quienes tengan más de 1500 de poder si hay más de 3 guardias, 
de lo contrario deben tener más de 1000 de poder. 
Los personajes que la logran atravesar, no les pasa nada.
*/
object lebennin 
{
    
    var property guardias = 3

    method modificarGuardias (valor)
    {
        guardias = valor
    }

    method puedePasar(unGuerrero) 
    {
        if(guardias > 3)
        {
            return unGuerrero.poder() > 1500
        }
        else
        {
            return unGuerrero.poder() > 1000
        }
            
    }

    method pasarPorAca(unGuerrero) 
    {
        if(self.puedePasar(unGuerrero))
        {
            unGuerrero.sacarVida(0)
        }

        //Que pasa si el guerrero no puede pasar?
    }      
}

/*
Integrante 2

Por Minas Tirith, en cambio, no hay chances de pasar sin tener armas. 
El pasar por esta zona complicada implica perder 10 unidades de vida por cada arma que tiene el guerrero.
*/
object minasTirith 
{
    
    method puedePasar(unGuerrero) 
    {
        return unGuerrero.tamanioArsenal() > 0
    }

    method pasarPorAca(unGuerrero) 
    {
        
        if(self.puedePasar(unGuerrero))
        {
            unGuerrero.sacarVida(10*unGuerrero.tamanioArsenal())
        }
        
        //Que pasa si el guerrero no puede pasar?

    }      
}

/*
Integrante 3

Lossarnach es otro lugar cercano, para el cual no hay requisitos para poder atravesarlo. 
Tanto es su simpleza que el guerrero la pasa bien y  aumenta su vida en 2 unidades  por cada arma que posee.
*/
object lossarnach 
{
    
    method puedePasar(unGuerrero) 
    {
        return true
    }

    method pasarPorAca(unGuerrero) 
    {
        if(self.puedePasar(unGuerrero))
        {
            unGuerrero.aumentarVida(2*unGuerrero.tamanioArsenal())
        }
       
    }      
}

/*
Integrante 4

También, un individuo puede intentar recorrer el camino de Gondor, 
que conduce de Lebennin a Minas Tirith. 
Para poder hacerlo debe poder recorrer ambas zonas y cuando lo hace sufre también las consecuencias correspondientes.
Eventualmente, el camino de Gondor puede modificarse y por ejemplo ir desde Lebennin a Lossarnach, o cualquier otra combinación posible.
*/
class CaminoDeGondor {
    
    var property lugares = [lebennin, minasTirith]

    method agregarLugar(lugar)
    {
        lugares.add(lugar)
    }

    method sacarLugar(lugar)
    {
        lugares.remove(lugar)
    }

    method puedeRecorrerCamino(unGuerrero) 
    {
        return lugares.all({lugar => lugar.puedePasar(unGuerrero)})
    }

    method realizarCamino(unGuerrero) 
    {
        return lugares.forEach({lugar => lugar.pasarPorAca(unGuerrero)})
    }
}


/* 
----- Tom Bombadil ----- 

Tom es un habitante más de la Tierra Media, es un sujeto muy particular y alegre. 
Usa una chaqueta azul brillante y unas botas amarillas y en su alto sombrero lleva una pluma de ala de cisne.

La particularidad de Tom, es que tiene el calendario de vacunación al día cosa que lo hace inmune a todo lo que le pase, 
su poder es siempre de 2000, y pareciera ser hijo de Rambo porque aunque no se sepa con qué… siempre tiene 100 armas. 
De esta forma, puede atravesar cualquier zona conocida de la Tierra Media sin sufrir alteración alguna.
*/
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


/* ENTREGA 2 */

/*
Espada: Cada espada tiene un multiplicador de poder entre 1 y 20, 
y además, mantiene el valor extra según el origen, 
pero ahora se considera como origen la naturaleza del guerrero que la porta.
Repasando cada uno de los valores de los orígenes:
    ○ Élfico: 25
    ○ Enano: 20
    ○ Humano: 15
    ○ Cualquier otro: 10 veces la cantidad
    de armas que lleve
*/
class Espada
{
    var multiplicadorBase
    
    method modifMultiplicadorBase (valor)
    {
        multiplicadorBase = valor
    }

    method poder(guerrero)
    {
        return guerrero.potenciador() * multiplicadorBase
    }
}

class EspadaGlamdring inherits Espada
{
    var magia 

    method magia(nuevaMagia) 
    {
        magia = nuevaMagia
    }
    
    override method poder(unGuerrero)
    {
        return 10 * magia.valorMagico(unGuerrero)
    }

}

/*
Báculo: Cada báculo sabe cual es el poder que otorga.
*/
/*class Baculo 
{
    
    var poderBase  = 250 

    method poderBase(nuevoPoder) 
    {
        poderBase = nuevoPoder
    }

    method poderPotenciado(unGuerrero) 
    {
        if(unGuerrero.vida() <= 10 )
            return poderBase*2
        else 
            return poderBase
    }

    method poder(unGuerrero) 
    {
        return 400.min(self.poderPotenciado(unGuerrero))
    }
}*/

/*
Daga: La daga es como una espada chiquita, por lo tanto el poder que otorga, 
es la mitad que daría una espada con sus mismas características.
*/
class Daga inherits Espada
{
    override method poder(unguerrero)
    {
        return (unguerrero.potenciador() * multiplicadorBase) / 2
    }

}

/*
Hacha: El hacha está compuesta de un mango, y una hoja metálica con filo. Y se calcula como
el largo del mango multiplicado por el peso de la hoja.
*/
class Hacha
{
    const unMango
    const unaHoja

    method poder(unguerrero)
    {
        return unMango.largo() * unaHoja.peso()
    }
}

class Mango 
{
    var property largo
}

class Hoja
{
    var property peso 
}

/*
Guerreros

Todos los guerreros tienen cosas en común. Por ejemplo, todos son capaces de llevar armas y pueden
también transportar elementos útiles para la realización de su viaje. Pero sin embargo, son de diferente
naturaleza y hay características propias que dependen de cada uno.
Esta tensión entre similitudes y diferencias se ve reflejada a la hora de calcular el poder de los
guerreros, de la siguiente manera.
*/

class Guerrero
{
    const nombre
    const naturaleza
    const poderBase

    var property vidaGuerrero
    
    const armasGuerrero = []
    const elementos = []
    

    method agregarArma (arma)
    {
        armasGuerrero.add(arma)
    }

    method armasGuerrero() 
    {
        return armasGuerrero
    }

    method tamanioArsenal() 
    {
       return armasGuerrero.size()
    }



    method poderArmas()
    {
        return armasGuerrero.sum({arma => arma.poder(self)})
    }

    method poder() = poderBase

    
    
    
    method sacarVida(unValor) 
    {
        vidaGuerrero = 0.max(vidaGuerrero - unValor)
    }

    method aumentarVida(unValor) 
    {
        vidaGuerrero = vidaGuerrero + unValor
    }

    
    
    
    method recorrerCamino(caminoDeGondor) 
    {
        if(caminoDeGondor.puedeRecorrerCamino(self))
        {
            caminoDeGondor.realizarCamino(self)
        }
    }
}

/*
Hobbits: Los hobbits son habitantes medianos del lugar. 
No representan una gran amenaza y su
cálculo de poder está dado por la siguiente fórmula:
○ vida actual + cantidad de elementos * sumatoria del poder de sus armas
*/
class Hobbits inherits Guerrero
{
    override method poder()
    {
        return vidaGuerrero + elementos.size() * self.poderArmas()
    }
}

/*
 Enanos: Los enanos suelen tener armas muy poderosas, por lo tanto su poder es:
○ vida actual + factor de poder * sumatoria del poder de sus armas
El factor de poder, es un número que depende de cada enano.
*/
class Enanos inherits Guerrero
{
    override method poder()
    {
        return vidaGuerrero + poderBase + self.poderArmas()
    }
}

/*
Elfos: Una de las características de los elfos es su destreza, representada por un número. Por
este motivo es que debemos considerarla a la hora de calcular su poder:
○ vida actual + (destrezaBase + destrezaPropia) * sumatoria del poder de
sus armas
○ La destreza base, es común para todos los elfos y puede cambiar. Hoy en día es de 2.
*/
class Elfos inherits Guerrero
{

    const destrezaBase = 2

    var property destrezaPropia

    method modifDestreza(valor)
    {
        destrezaPropia = valor
    }

    override method poder()
    {
        return vidaGuerrero + (destrezaBase + destrezaPropia) * self.poderArmas()
    }
}

/*
Humanos: Probablemente son los más comunes, pero no por eso los menos importantes. Su
cálculo de poder está dado por:
○ vida actual + sumatoria del poder de sus armas / limitador de Poder
El imitador de poder es particular para cada ser humano
*/
class Humanos inherits Guerrero
{

    var property limitadorPoder 

    override method poder()
    {
        return vidaGuerrero + self.poderArmas() / limitadorPoder
    }
}

/*
Maiar: Gandalf es uno de ellos. La forma en la cual calcula su poder es representativa de todos
los maiares. Los valores de 15 y 300 son factores de poder básico y poder bajo amenaza,
respectivamente, que podrían llegar a cambiar.
 vida actual * factor actual + 2 * sumatoria del poder de sus armas

*/
class Maiar inherits Guerrero
{
    var property poderBasico = 15
    var property poderBajoAmenaza = 300 

    var property bajoAmenaza = false 

    /*method poder() //tomado a Gandalf
    {   
        if (self.vidaGuerrero() < 10)
        {
            return (vidaGuerrero * 200) + (self.poderArmas() * 2)
        }

        return (vidaGuerrero * 15) + (self.poderArmas() * 2)
    }*/

    override method poder()
    {
        if(bajoAmenaza)
        {
            return vidaGuerrero * poderBajoAmenaza + 2 * self.poderArmas()
        }
        else
        {
            return vidaGuerrero * poderBasico + 2 * self.poderArmas()
        }
    }

}

/*
Gollum: Gollum es un ser particular dentro de la Tierra Media que fue totalmente afectado 
por el anillo único. Su cálculo de poder es como el de cualquier hobbit, 
pero la mitad de ese.
*/

class Gollum inherits Hobbits
{
    override method poder()
    {
        return super() / 2
    }

}

/*
Modelado para Tests
*/





