import wollok.game.*
import moto.*
import visuales.*
import powerup.*

class Jugador {
	var property vida
	//var property position = game.at(1,9)
	const property moto
	var property jugadorEnemigo  = null
	const powerups = #{}
	
	method cantidadDeVidas(){
		return vida.vidas()
	}
	
	method initialize(){
		moto.jugador(self)
	}
	
	method motoEnemiga(){
		return jugadorEnemigo.moto()
	}
	
	method perderVida(){
		vida.perderVida()
	}
	
	method agregarPowerup(power){
		if (powerups.size() >= 1) {
			administradorPowerups.eliminar(power)
		}
		else {
			powerups.add(power)
			administradorPowerups.eliminar(power)
		}
	}
	
	method usarPowerUp() {
		if(powerups.isEmpty()) {
			game.say(self.moto(), self.mensajePower())
		}
		else {self.usarPoder(powerups.uniqueElement()) }
	}
	
	method mensajePower() {
		return "No tengo ningun powerup"
	}
	
	method usarPoder(power) {
		power.activar(self)
		powerups.remove(power)
	} 
	
}

