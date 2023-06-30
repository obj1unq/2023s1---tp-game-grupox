import wollok.game.*

class Vida {
	var property position
	var property vidas = 3
	
	method image(){
		return "vidas-" + vidas.toString() + "corazon.png"
	}
	
	method perderVida() {
		if (vidas >= 1) {
			vidas -= 1
		} 
	}  
	
	method agregarVida() {
		game.addVisual(self)
	}
	
}

class Player {
	var numero
	var property position
	
	method image(){
		return "player" + numero.toString() + ".png"
	}
	
	method agregarPlayer(){
		game.addVisual(self)
	}
}

class Categoria {
	method image()
	
	method position()
}

object jugador1Ganador inherits Categoria {
	override method image(){
		return "jugador1-ganador.png"
	}
	
	override method position() = game.at(3, 6)
}

object jugador2Ganador inherits Categoria {
	override method image(){
		return "jugador2-ganador.png"
	}
	
	override method position() = game.at(3, 6)
}

object jugador1Perdedor inherits Categoria {
	override method image(){
		return "jugador1-perdedor.png"
	}
	
	override method position() = game.at(4, 4)
}

object jugador2Perdedor inherits Categoria {
	override method image(){
		return "jugador2-perdedor.png"
	}
	
	override method position() = game.at(4, 4)
}

object quit {
	method image(){
		return "presionar-x.png"
	}
	
	method position() = game.at(6,2)
}

class PowerupGuardado {
	var property position
	var powerupAgarrado 
	
	method image() {
		return "simbolo-" + powerupAgarrado + "-icono.png"
	}
	
	method powerupAgarrado(poder) {
		if(poder.id() == 1) {
			powerupAgarrado = "limpieza"
		}
		else {powerupAgarrado = "proteccion"}
	} 
	
	method powerupUsado() {
		powerupAgarrado = "vacio"
	}
	
	method agregarPowerupGuardado() {
		game.addVisual(self)
	}
}

