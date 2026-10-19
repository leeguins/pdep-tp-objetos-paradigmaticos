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
    var property origen

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


  method tamanioArsenal() {
    return arsenal.size()
  }

  method estaArmado() {
    return !arsenal.isEmpty()
  }

  method poderArsenal() {
    return arsenal.sum({arma => arma.poder(self)})
  }

  method poderGuerrero() 
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

  override method poderGuerrero() {
    return self.poderHobbietson()
  }
}

// Defino al objeto Golumn, que hereda de los Hobbit
object golumn inherits Hobbit (vida = 50, arsenal = [], objetos = []) {
  /*  En estos casos que creo un objeto unico que hereda de una clase, debo definir los atributos obligatorios. 
      Pero estos vienen de la atadura con su abuelo = Guerrero.
  */
  override method poderGuerrero() {
    return super() / 2
  }
}

// Defino la clase para los Enanos
class Enano inherits Guerrero (naturaleza = enano) {
  var property factorPoder

  method poderEnano() {
    return vida + (factorPoder * self.poderArsenal())
  }

  override method poderGuerrero() {
    return self.poderEnano()
  }
}

// Defino la clase para los Elfos
class Elfo inherits Guerrero (naturaleza = elfico) {
  var property destrezaPropia
  var property destrezaBase = 2

  method poderElfico() {
    return vida + ((destrezaPropia + destrezaBase) * self.poderArsenal())
  }

  override method poderGuerrero() {
    return self.poderElfico()
  }
}

// Defino la clase para los Humanos
class Humano inherits Guerrero (naturaleza = humano) {
  var property limitadorPoder

  method poderHumano() {
    return vida + (self.poderArsenal() / limitadorPoder)
  }

  override method poderGuerrero() {
    return self.poderHumano()
  }
}

// Defino la clase para los Maiars
// Defino los objetos para los dos unicos factores Maiar.
object factorBasico {
  method valor() {
    return 15
  }
}

object factorBajoAmenaza {
  method valor() {
    return 300
  }
}

class Maiar inherits Guerrero (naturaleza = otraNaturaleza) {
  var property factorMaiar

  method poderMaiar() {
    return vida * (factorMaiar.valor() + 2) * self.poderArsenal()
  }

  override method poderGuerrero() {
    return self.poderMaiar()
  }
}

// Defino al objeto Tom Bombadil
object tomBombadil {
  const vida = 1000
  const arsenal = []
  const objetos = []
  const property naturaleza = otraNaturaleza

  method tamanioArsenal () {
    return 1000
  }
  method estaArmado () {
    return true
  }
  method tamanioBolsa () {
    return 1000
  }
  method llevaObjetos () {
    return true
  }

  method poderGuerrero() {
    return 10000000
  }
}