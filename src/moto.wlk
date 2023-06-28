import wollok.game.*
import direcciones.*
import escenario.*


class Estado {
	method iniciar(moto) {
		game.say(moto,  self.mensaje() + "Me quedan " + moto.jugador().cantidadDeVidas() + " vidas")
		game.removeTickEvent("ALKORTE")
	}
	
	method puedeMover(){
		return false
	}
	
	method mensaje()
}

object muerto inherits Estado {
	
	override method iniciar(moto){
		moto.jugador().vida().perderVida()
		super(moto)
		if(moto.jugador().cantidadDeVidas() > 0){
			//TODO: que cuando muera, reinicie el juego, manteniendo la cantidad de vidas
			//que le queda a cada jugador
			//game.clear()
		}
	}
	
	override method mensaje(){
		return "Choque"
	}

}

object ganador inherits Estado { 
	
	override method mensaje(){
		return "Gane"
	}
	 
}

object vivo {
	method iniciar(moto){
		
	}	
	method puedeMover(){
		return true
	}
}


class Moto {
	var property estado = vivo
	var property position = game.at(0,0)
	var property direccionApuntada  = arriba
	var property posicionAnterior = game.at(0,0)	
	var property jugador = null
	
	method enemigo(){
		return jugador.motoEnemiga()
	}
	
	method image() {
		return "Moto" + self.direccionApuntada().toString() + ".png"
	}
	
	method estado(){
		return estado
	}
	

	method estado(_estado){
		estado = _estado
		estado.iniciar(self)
	}
	
	method morir(){
		self.estado(muerto)
	}
	
	method gane(){
		self.estado(ganador)
	}
	method validarDesplazar(direccion, cantidad) {
		direccion.validarMover(self, cantidad)
	}
	
	method puedeMover(direccion, cantidad){
			return estado.puedeMover() and direccion.puedeMover(self, cantidad)
	}
	
	method desplazar(direccion, cantidad){
		direccion.mover(self, cantidad)
	}
	
	method moverSiPuede(direccion, cantidad){
		if (self.puedeMover(direccion, cantidad)) {
			self.direccionApuntada(direccion)
			self.desplazar(direccion, cantidad)
		}
	}
	
	method alcorte() {
		if (direccionApuntada.puedeMover(self,1)) {
			self.posicionAnterior(self.position())
			self.desplazar(direccionApuntada, 1)
			self.generarTrazo()
		} else {
			self.morir()
			self.enemigo().gane()
		}
	}

	method generarTrazo(){
		game.addVisual(new Trazo(position=self.posicionAnterior()))
	} 
	
}