
/* ENTREGA 1 */


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

class Espada
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

}

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

object gandalf
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

}

class Guerrero
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
}

/* ----- Zonas de la Tierra Media ----- */
object lebennin {
    
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

object minasTirith {
    
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

object lossarnach {
    
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



/* ENTREGA 2 */

