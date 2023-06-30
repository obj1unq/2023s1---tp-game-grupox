import wollok.game.*
import moto.*
import visuales.*
import powerup.*

class Jugador {
	var property vida = null
	var property moto = null
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
	
	method puedeJugar(){
		return self.cantidadDeVidas() > 0
	}
	
	method validarSiPuedeJugar(){
		if(not self.puedeJugar()){
			self.error("No me quedan mas vidas para jugar")
		}
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

object crearJugadores {
	var property tipoDeMotoP1 = "x"
	var property tipoDeMotoP2 = "x"
	
	method crearMoto(tipoDeMoto) {
		if (tipoDeMoto == "Basica") {
			return new MotoBasica()
		} else if (tipoDeMoto == "Rapida") {
			return new MotoRapida()
		} else return new MotoExplosiva()
	}
	
	method crearVida(x) {
		return new Vida(position = game.at(x,9))
	}
	
//	method comprobarMismaMoto() {
//		if (self.tipoDeMotoP1() == self.tipoDeMotoP2()) {
//			self.motosAlternativas(tipoDeMotoP2())
//		} else return self.crearMoto(self.tipoDeMotoP2())
//	}
//	
//	method motosAlternativas(tipoP2) {
//		if (tipoP2 == "Basica") {
//			return new MotoBasica(tipoDeMoto="MotoAlternativa")
//		} else if (tipoP2 == "Rapida") {
//			return new MotoRapida(tipoDeMoto="MotoAlternativa")
//		} else return new MotoExplosiva(tipoDeMoto="MotoAlternativa")
//	}
}