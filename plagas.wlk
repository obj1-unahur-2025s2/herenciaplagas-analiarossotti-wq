//Super Clase - Clase Padre
class Plaga {
    var poblacion
    method transmiteEnfermedad() = poblacion >= 10

    method atacarElemento() {
        poblacion * 1.1
    }
}

//Sub Clase
class PlagaDeCucarachas inherits Plaga {
    var pesoPromedio
    
    method nivelDeDaño() {
      return poblacion / 2
    }

    override method transmiteEnfermedad() {
      return super() and (pesoPromedio >= 10)
    }

    override method atacarElemento() {
        super()
        pesoPromedio += 2
    }
}

class PlagaDePulgas inherits Plaga {
    method nivelDeDaño() = poblacion * 2
}

//Mismas condiciones que plaga de pulgas
class PlagaDeGarrapatas inherits PlagaDePulgas {
    override method nivelDeDaño() = poblacion
    
    override method atacarElemento() {
        poblacion * 1.2
    }
}

class PlagaDeMosquitos inherits Plaga {
    method nivelDeDaño() = poblacion
    
    override method transmiteEnfermedad() {
        return super() and (poblacion % 3 == 0)
    }
}

class Hogar {
    var  nivelDeMugre
    const confort
    
    method asignarNivelDeMugre(unNivel) { nivelDeMugre = unNivel return nivelDeMugre } 
    method esBueno() = nivelDeMugre <= confort / 2

    method recibeAtaqueDe(unaPlaga) {
        nivelDeMugre += unaPlaga.nivelDeDaño()
        unaPlaga.atacarElemento()
    }
}

class Huerta {
    var capacidad

    method esBueno() = capacidad > nivelMinimo.valor()

    method recibeAtaqueDe(unaPlaga) {
        capacidad = 0.max(capacidad - (unaPlaga.nivelDeDaño() * 0.1)) //no puede ser menor a 0
        capacidad = 0.max(capacidad - if (unaPlaga.transmiteEnfermedad()) 10 else 0) //si la plaga transmite enfermedades, le resto 10
        unaPlaga.atacarElemento()
    }

    /*
    method recibeAtaqueDe(unaPlaga) {
        if(unaPlaga.transmiteEnfermedad()) {
            produccion -= 0.max(unaPlaga.nivelDeDaño() * 0.1 - 10)
        } else {produccion -= 0.max(unaPlaga.nivelDeDaño() * 0.1) }
    }
    */
}

object nivelMinimo {
var property valor = 100
}

class Mascota {
    var nivelDeSalud

    method esBueno() = nivelDeSalud > 250

    method recibeAtaqueDe(unaPlaga) {
        if (unaPlaga.transmiteEnfermedad()) {
            nivelDeSalud = 0.max(nivelDeSalud - 
            if(unaPlaga.transmiteEnfermedad()) unaPlaga.nivelDeDaño() else 0)
        } 
        unaPlaga.atacarElemento()
    }
}

class Barrio {
    const elementos = []
    method agregarNuevoElemento(elemento) {
        elementos.add(elemento)
    }

    method esCopado() {
        self.elementosBuenos() > self.elementosNoBuenos()
    }

    method elementosBuenos() {
        return elementos.count({ e => e.esBueno()})
    }
    method elementosNoBuenos() {
       return elementos.count({ e => !e.esBueno()})
    }
}


