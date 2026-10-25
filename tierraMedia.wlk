
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
        return guerrero.vida() < 10
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
        return unGuerrero.vida()/2
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
    var property vida = 100
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
        if (self.vida() < 10)
        {
            return (vida * 200) + (self.poderArmas() * 2)
        }

        return (vida * 15) + (self.poderArmas() * 2)
    }

    method sacarVida(unValor) {
        vida = 0.max(vida - unValor)
    }

    method aumentarVida(unValor) {
        vida = vida + unValor
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
object tomBombadil inherits Guerrero (vida = 2000, naturaleza = otraNaturaleza) {

  override method tamanioArsenal () {
    return 1000
  }
  override method estaArmado () {
    return true
  }
  method tamanioBolsa () {
    return 1000
  }
  method llevaObjetos () {
    return true
  }

  override method poder() {
    return 10000000
  }

  override method sacarVida(unValor) {
  } // No pierde vida, es inmortal.

  override method aumentarVida(unValor) { 
  } // no hace nada
}



// ------- ENTREGA 2 -------
// ARSENAL

// Defino la clase para las Armas
class Arma {
    method poder(unGuerrero)
}

/*  Las naturalezas no aportan mas que un valor, no tienen atributos o estados variables.
    No hay dos tipos elficos, y todas deben tener el mismo metodo y parametros para Polimorfismo.
 */
object elfico {
  method valor(unGuerrero) {
    return 25
  }
}

object enano {
  method valor(unGuerrero) {
    return 20
  }
}

object humano {
  method valor(unGuerrero) {
    return 15
  }
}

object otraNaturaleza {
  method valor(unGuerrero) {
    return 10 * unGuerrero.tamanioArsenal()
  }
}

// Defino la clase para las Espadas
class Espada inherits Arma {
    var property multiplicador

    method poderExtra(unGuerrero) {
        return unGuerrero.naturaleza().valor(unGuerrero) // Paso la naturaleza del guerrero
    }

    override method poder(unGuerrero) {
        return self.poderExtra(unGuerrero) * multiplicador
    }

}

// Defino la clase para las Dagas, hijas de la espada
class Daga inherits Espada {
    override method poder(unGuerrero) {
        return super(unGuerrero) / 2 // Con "super", traigo el resultado de hacer poder(unGuerrero) en una Espada
    }

}

// Defino la clase para los Baculos
class Baculo inherits Arma {
    var property poderBase

    override method poder(unGuerrero) {
        return poderBase
    }
}

// Defino la clase para las Hachas
class Hacha inherits Arma {
    var property mango
    var property hoja


    override method poder(unGuerrero) {
        return mango * hoja
    }
}

// SOBRE LOS GUERREROS

// Defino la clase para los Guerreros
class Guerrero {
  var property vida
  var property arsenal = []
  var property objetos = []
  var property naturaleza
  var property tactica = tacticaDefault


  method tamanioArsenal() {
    return arsenal.size()
  }

  method estaArmado() {
    return !arsenal.isEmpty()
  }

  method poderArsenal() {
    return arsenal.sum({arma => arma.poder(self)})
  }

  method armaMasPoderosa() = arsenal.max({arma => arma.poder(self)})
  
  method perderArmaMasPoderosa() {
    if (!arsenal.isEmpty()) {
      arsenal.remove(self.armaMasPoderosa())
    }
  }

  method esGrupo() = false

  method sacarVida(unValor) {
    vida = 0.max(vida - unValor)
  }

  method aumentarVida(unValor) {
    vida = vida + unValor
  }

  method recorrerCamino(camino) {
    if (camino.puedeRecorrerCamino(self)) {
      camino.realizarCamino(self)
    } else {
      camino.penalizar(self)
      self.error("No se puede recorrer el camino")
    }
  }

  method poder()

  method atacar(oponente) {
    if (self.vida() > 0) {
      oponente.recibirAtaque(self.poder() * 0.10)
    }
  }

  method recibirAtaque(danio) {
    self.sacarVida(danio)
  }

  method enfrentar(oponente){
    tactica.pelear(self,oponente)
  }
}

// Defino la clase para los Hobbits
class Hobbit inherits Guerrero (naturaleza = otraNaturaleza) {

  method tamanioBolsa() { // Mas para los hobbits
    return objetos.size()
  }

  method llevaObjetos() { // Mas para los hobbits
    return !objetos.isEmpty()
  }

  method poderHobbietson() {
    return vida + (self.tamanioBolsa() * self.poderArsenal())
  }

  override method poder() {
    return self.poderHobbietson()
  }
}

// Defino al objeto Golumn, que hereda de los Hobbit
object golumn inherits Hobbit (vida = 50, arsenal = [], objetos = []) {
  /*  En estos casos que creo un objeto unico que hereda de una clase, debo definir los atributos obligatorios. 
      Pero estos vienen de la atadura con su abuelo = Guerrero.
  */
  override method poder() {
    return super() / 2
  }
}

// Defino la clase para los Enanos
class Enano inherits Guerrero (naturaleza = enano) {
  var property factorPoder

  method poderEnano() {
    return vida + (factorPoder * self.poderArsenal())
  }

  override method poder() {
    return self.poderEnano()
  }
}

// Configuración compartida por todos los elfos
object elfos {
  var property destrezaBase = 2
} 

// Defino la clase para los Elfos
class Elfo inherits Guerrero (naturaleza = elfico) {
  var property destrezaPropia

  method poderElfico() {
    return vida + ((destrezaPropia + elfos.destrezaBase()) * self.poderArsenal())
  }

  override method poder() {
    return self.poderElfico()
  }
}

// Defino la clase para los Humanos
class Humano inherits Guerrero (naturaleza = humano) {
  var property limitadorPoder

  method poderHumano() {
    return vida + (self.poderArsenal() / limitadorPoder)
  }

  override method poder() {
    return self.poderHumano()
  }
}

// Defino la clase para los Maiars
class Maiar inherits Guerrero (naturaleza = otraNaturaleza) {
  var property poderBasico = 15
  var property poderBajoAmenaza = 300
  method estaBajoAmenaza() = self.vida() < 10

  override method poder() {
    if (self.estaBajoAmenaza()) {
      return vida * poderBajoAmenaza + 2 * self.poderArsenal()
    } else {
      return vida * poderBasico + 2 * self.poderArsenal()
    }
  }
}

// ----- Los Caminos de la Tierra Media -----

// validacion de entidad para ver si es un grupo o si es un guerrero individual, y devolver la lista de integrantes}
// Grupo tiene esGrupo en true, y guerrero en false.
object gruposHelper {
  method integrantesDe(entidad) {
    if (entidad.esGrupo())
      return entidad.guerreros()
    else
      return [entidad] // lista de 1 elemento, el guerrero solo
  }
}


class Grupo {
  var property guerreros = []

  method esGrupo() = true

  method recorrerCamino(camino) {
    if (camino.puedeRecorrerCamino(self)) {
      camino.realizarCamino(self)
    } else {
        camino.penalizar(self)
        self.error("No se puede recorrer el camino")
    } 
  }
}

class Zona {
  var property requerimientosExtra = []

  method puedePasar(entidad) {
    if (!self.cumpleRequisitoBase(entidad)) {
      return false
    }
    if (!requerimientosExtra.isEmpty()) {
      return requerimientosExtra.all({ r => r.seCumple(entidad) })
    }
    return true
  }

  method pasarPorAca(entidad) {
    if (self.puedePasar(entidad)) {
      self.aplicarConsecuencia(entidad)
    }
  }

  // Esqueletos para overridear despues en cada zona.
  method cumpleRequisitoBase(entidad) 
  method aplicarConsecuencia(entidad)
}

// Lebennin: solo pasan quienes tengan más de cierto poder. No hay consecuencia.
class ZonaConPoderMinimo inherits Zona {
  var poderMinimoValor = 0

  method poderMinimo() = poderMinimoValor

  override method cumpleRequisitoBase(entidad) {
    return gruposHelper.integrantesDe(entidad).all({ g => g.poder() > self.poderMinimo() })
  }

  override method aplicarConsecuencia(entidad) {
  } // no hace nada, pero la tengo que traer igual
}

// Lebennin en particular: el umbral sube a 1500 si hay más de 3 guardias.
class ZonaDeLebennin inherits ZonaConPoderMinimo {
  var property guardias = 3

  override method poderMinimo() {
    if (guardias > 3)
      return 1500
    else
      return 1000
  }
}

// Minas Tirith: hace falta estar armado, y se pierde vida por cada arma.
class ZonaQueRequiereArmas inherits Zona {
  var property vidaPerdidaPorArma

  override method cumpleRequisitoBase(entidad) {
    return gruposHelper.integrantesDe(entidad).all({ g => g.estaArmado() })
  }

  override method aplicarConsecuencia(entidad) {
    gruposHelper.integrantesDe(entidad).forEach({ g => g.sacarVida(vidaPerdidaPorArma * g.tamanioArsenal()) })
  }
}

// Lossarnach: sin requisitos, se gana vida por cada arma.
class ZonaLibre inherits Zona {
  override method cumpleRequisitoBase(entidad) = true

  override method aplicarConsecuencia(entidad) {
    gruposHelper.integrantesDe(entidad).forEach({ g => g.aumentarVida(2 * g.tamanioArsenal()) })
  }
}

// Penalidad por defecto: no hace nada
object sinPenalidad {
  method aplicarA(guerrero) {
  }
}

object penalidadPerderTodaLaVida {
  method aplicarA(guerrero) {
    guerrero.sacarVida(guerrero.vida())
  }
}

// Un camino atraviesa una secuencia de zonas.
class Camino {
  var property lugares = []
  var property penalidad = sinPenalidad

  method puedeRecorrerCamino(entidad) {
    return lugares.all({ lugar => lugar.puedePasar(entidad) })
  }

  method realizarCamino(entidad) {
    lugares.forEach({ lugar => lugar.pasarPorAca(entidad) })
  }

  method penalizar(entidad) {
    gruposHelper.integrantesDe(entidad).forEach({ guerrero => penalidad.aplicarA(guerrero) })
  }
}

// La Tierra Media está compuesta de regiones, cada una con su propio camino.
class Region {
  var property nombre
  var property camino
}

// Camino Gondor, con Lossarnach,Lebennin y Minas Tirith.
object gondor inherits Region (
  nombre = "Gondor",
  camino = new Camino(lugares = [
    new ZonaLibre(),
    new ZonaDeLebennin(),
    new ZonaQueRequiereArmas(vidaPerdidaPorArma = 10)
  ])
) {
}

class RequerimientoDeElemento {
  var property nombre
  var property cantidad

  method seCumple(entidad) {
    return gruposHelper.integrantesDe(entidad).sum({ g => g.objetos().count({ o => o == nombre }) }) >= cantidad
  }
}

class RequerimientoDeGuerrero {
  var property condicion

  method seCumple(entidad) {
    return gruposHelper.integrantesDe(entidad).any(condicion)
  }
}


// ------- ENTREGA 3 -------

// Tacticas 
object tacticaDefault {
  method pelear(atacante, oponente) {
    atacante.atacar(oponente)
    oponente.atacar(atacante)
  }
}

object tacticaAgil {
  method pelear(atacante, oponente) {
    if(atacante.vida() > 0) { 
      oponente.recibirAtaque((atacante.poder() + 100) * 0.10)
    }
    oponente.atacar(atacante)
  }
}

object tacticaResistencia {
  method pelear(atacante, oponente) {
    if(oponente.vida() > 0) { 
      atacante.recibirAtaque(oponente.poder() * 0.10 / 2)
    }
    atacante.atacar(oponente)
  }
}

object tacticaLaCuatroTresTres {
  method pelear(atacante, oponente) {
    atacante.atacar(oponente)
    atacante.atacar(oponente)
    if (atacante.vida() <= 60) {
      oponente.atacar(atacante)
    }
  }
}

// Caruso no es objeto, va con clase porque el umbral puede variar por guerrero que quiera usar esta tactica.
// Un grande caruso, no me midaaa

class TacticaCaruso {
  var property umbral

  method pelear(atacante, oponente) {
    if (oponente.poder() > umbral) {
      atacante.atacar(oponente)
      oponente.atacar(atacante)
    } else {
      atacante.sacarVida(10)
    }
  }
}