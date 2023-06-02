import wollok.game.*
import direcciones.*

object muerto {
	method iniciar(moto) {
		game.say(moto,  "Choque")
		game.removeTickEvent("ALKORTE")
	}
	method puedeMover(){
		return false
	}
}

object vivo {
	method iniciar(moto){
		
	}	
	method puedeMover(){
		return true
	}
}

object ganador {
	method iniciar(moto){
		game.say(moto, "Gane")
		game.removeTickEvent("ALKORTE")
	}
	method puedeMover(){
		return false
	}
}

class Trazo {
	
	var property position
	var property image = "trazo.png"
	
	method chocar(objeto){
		objeto.morir()
		objeto.enemigo().gane()
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