import wollok.game.*
import moto.*
import visuales.*

class Jugador {
	var property vida
	//var property position = game.at(1,9)
	const property moto
	var property jugadorEnemigo  = null
	
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
	
	
}