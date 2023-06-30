import wollok.game.*

class Vida {
	var property position
	var property vidas = 3
	
	method image(){
		return "vidas-" + vidas.toString() + "corazon.png"
	}
	
	method perderVida(){
		vidas -= 1
	}
	
	method agregarVida() {
		game.addVisual(self)
	}
	
}

class Player {
	var numero
	var property position
	
	method image(){
//		return "player1-" + numero.toString() + ".png"
		return "player" + numero.toString() + ".png"
	}
	
	method agregarPlayer(){
		game.addVisual(self)
	}
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

//object vidaJugador1 {
//	//const property vida = new Vida (vidas = [game.at(17, 9), game.at(18, 9), game.at(19, 9)])
//	const property vida = new Vida(vidas = [game.at(17, 9), game.at(18, 9), game.at(19, 9)])
//}
//
//object vidaJugador2 {
//	//const property vida = new Vida (vidas = [game.at(3, 9), game.at(4, 9), game.at(5, 9)])
//	const property vida = new Vida(vidas = [game.at(17, 9), game.at(18, 9), game.at(19, 9)])
//}
