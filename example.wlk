
/* ----- Armas Peligrosas ----- */

/*
Integrante 1

El báculo otorga como máximo 400 unidades de poder. 
Se calcula con un poder base de 250 que se duplica si el guerrero que lo utiliza tiene poca vida. 
El poder base puede cambiar a lo largo del tiempo.

*/
object baculo 
{
    var poderBase = 400

    method modificarPoder(nuevoValor)
    {
        poderBase = nuevoValor
    }

    method poder(guerrero) {
        
        if (self.tienePocaVida(guerrero))
        {
            return 250
        }
        else
        {
            return poderBase.min(400)
        }

        /*
            if(guerrero.vida() < 10) // Para analizar mas adelante como cambio, depende de la responsabilidad
        */

    }

    method tienePocaVida(guerrero)
    {
        return guerrero.vida() < 10
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

object magiaElfica 
{

  method poderMagia(guerrero, espada) 
    {
      return espada.valorMagia() * 10
    }

}

object magiaEnana
{

  method poderMagia(guerrero, espada)
  {
    return (guerrero.vida() / 2) * 10
  }

}

object espada
{

    var esMagia = magiaElfica /* elfica o enana */
    var valorMagia = 25

    method modificarTipoMagia(tipoMagia)
    {
        esMagia = tipoMagia
    }
    
    method modificarMagia(valor)
    {
        valorMagia = valor
    }

    method valorMagia()
    {
      return valorMagia
    }

    method poder(guerrero)
    {
        return esMagia.poderMagia(guerrero, self)
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
    var diaActual = 10092026 /* dia/mes/año */
    var diaLustrado = 01012026 

    method cambiarDiaActual(fecha)
    {
        diaActual = fecha
    }

    method lustrarFlecha()
    {
        diaLustrado = diaActual
    }

    // Convierte un numero ddmmaaaa en una fecha de Wollok
    method aFecha(numero) 
    {
        //Date es una clase de la biblioteca estandar de Wollok
        return new Date(day = numero.div(1000000),month = numero.div(10000) % 100,year = numero % 10000)
    } 

    method conteoDias()
    {
       return self.aFecha(diaActual) - self.aFecha(diaLustrado)
    }

    method poderFlecha()
    {
        return (100 - self.conteoDias()).max(0)
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

    method poder(guerrero)
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
    var vidaGuerrero = 100
    const armasGuerrero = [baculo, espada, cajaFlechasNegras]

    method modificarVida(nuevoValor)
    {
        vidaGuerrero = nuevoValor
    }

    method vida() 
    {
        return vidaGuerrero
    }

    method poderArmas()
    {
        return armasGuerrero.sum({arma => arma.poder(self)})
    }

    method poder()
    {   
        if (self.vida() < 10)
        {
            return (vidaGuerrero * 200) + (self.poderArmas() * 2)
        }

        return (vidaGuerrero * 15) + (self.poderArmas() * 2)
    }

}
