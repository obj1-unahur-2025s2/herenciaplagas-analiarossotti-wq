//Super Clase - Clase Padre
class Plaga {
    var poblacion //declaro los valores que van a ser necesarios para instanciar la clase

    method transmiteEnfermedad() = poblacion >= 10

    method atacarElemento() { poblacion * 1.1 }
}

//Sub Clase
class PlagaDeCucarachas inherits Plaga {
    var pesoPromedio
    
    method nivelDeDaño() = if(poblacion >= 10) poblacion/2 else 0

    override method transmiteEnfermedad() { //poblacion >= 10
      return super() and (pesoPromedio >= 10)
    }

    override method atacarElemento() {
        super()     //poblacion * 1.1
        pesoPromedio += 2
    }
}

class PlagaDePulgas inherits Plaga {
    method nivelDeDaño() = if(poblacion >= 10) poblacion*2 else 0
}

/*El _nivel de daño_ que producen, y el criterio para determinar si _transmiten enfermedades_, 
    son iguales a los de la plaga de pulgas. Más adelante va a aparecer una diferencia entre pulgas y garrapatas. */
class PlagaDeGarrapatas inherits PlagaDePulgas {
    override method nivelDeDaño() = if(poblacion >= 10) poblacion else 0
    
    override method atacarElemento() {  //sobre escribo el metodo, porque cambia el valor
        poblacion * 1.2
    }
}

class PlagaDeMosquitos inherits Plaga {
    method nivelDeDaño() = if(poblacion >= 10) poblacion else 0
    
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
    
    method agregarNuevoElemento(elemento) = elementos.add(elemento)

    method elementosBuenos() = elementos.count({ e => e.esBueno()})

    method elementosNoBuenos() = elementos.count({ e => !e.esBueno()})

    method esCopado() = self.elementosBuenos() > self.elementosNoBuenos()
}

