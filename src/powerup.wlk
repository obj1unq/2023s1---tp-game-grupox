import wollok.game.*
import randomizer.*

class Powerup {
	
	var property position = game.at(5,5)
	
	method activar(jugador)
	
	method image()
	
	method chocar(objeto) {
		objeto.jugador().agregarPowerup(self)
	}
	
}


class Limpieza inherits Powerup {
	
	var property id = 1
	
	override method activar(jugador) {
		jugador.moto().limpiarTrazos()
		jugador.motoEnemiga().limpiarTrazos()
	}
	
	override method image() {
		return "limpieza.png"
	}
}


class Proteccion inherits Powerup {
	var property id = 2
	
	override method activar(jugador) {
		jugador.moto().proteccionActivada()
	}
	
	override method image() {
		return "proteccion.png"
	}
}


object generadorLimpieza {
	method nuevo() {
		return new Limpieza(position = randomizer.emptyPosition())
	}
}


object generadorProteccion {
	method nuevo() {
		return new Proteccion(position = randomizer.emptyPosition())
	}
}

object administradorPowerups {
	
	const generados = #{}
	const limite = 1
	const generadores = [ generadorLimpieza, generadorProteccion]
	
	method generar() {
		if(generados.size() < limite) {
			const poder = self.nuevoPowerup()	
			game.addVisual(poder)
			generados.add(poder)
		}
	}
	
	method eliminar(poder) {
		game.removeVisual(poder)
		generados.remove(poder)
	}
	
	method elegirGenerador() {
	     return generadores.anyOne()  
	}

	method nuevoPowerup() {
		return self.elegirGenerador().nuevo()
	}
	
}

