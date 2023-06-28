import wollok.game.*
import direcciones.*

class Estado {
	method iniciar(moto) {
		game.say(moto,  self.mensaje())
		game.removeTickEvent("ALKORTE")
	}
	
	method puedeMover(){
		return false
	}
	
	method mensaje()
}

object muerto inherits Estado {
	
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

class Trazo {
	
	var property position
	var property image = "trazo.png"
	
	method chocar(objeto){
		objeto.morir()
		objeto.enemigo().gane()
	}
	
}
class MotoBasica {
	var property estado = vivo
	var property position = game.at(0,0)
	var property direccionApuntada  = arriba
	var property posicionAnterior = game.at(0,0)	
	var property jugador = null
	const property velocidad = 300 //más baja = más rápido
	const property tipoDeMoto = "MotoBasica"
	
	method enemigo(){
		return jugador.motoEnemiga()
	}
	
	method image() {
		return self.tipoDeMoto() + self.direccionApuntada().toString() + ".png"
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
			 self.efectoDeAlcorte()
		} else {
			self.morir()
			self.enemigo().gane()
		}
	}
	
	method efectoDeAlcorte() {
		self.generarTrazo(self.posicionAnterior())
	}
	
	method generarTrazo(posicion){
		game.addVisual(new Trazo(position=posicion))
	}
}

class MotoRapida inherits MotoBasica {
	var property trazoOn = false
	
	override method velocidad() {
		return super() * 0.75
	}
	
	override method tipoDeMoto() {
		return "MotoRapida"
	}
	
	override method efectoDeAlcorte() {
		self.generarTrazoRapido(self.posicionAnterior())
	}
	
	method generarTrazoRapido(posicion){
		if (self.trazoOn()) {
			self.generarTrazo(posicion)
			trazoOn = false
			} else trazoOn = true
	}
	
}

class MotoExplosiva inherits MotoRapida {
	
	override method velocidad() {
		return 250
	}
	
	override method tipoDeMoto() {
		return "MotoExplosiva"
	}
	
	override method efectoDeAlcorte() {
		self.generarTrazoExplosivo()
	}
	
	method generarTrazoExplosivo() {
		if (self.direccionApuntada() == arriba or self.direccionApuntada() == abajo) {
			trazoOn = true
			self.generarTrazoRapido(self.posicionAnterior().right(1))
			trazoOn = true
			self.generarTrazoRapido(self.posicionAnterior().left(1))
		} else 
		    trazoOn = true
			self.generarTrazoRapido(self.posicionAnterior().down(1))
			trazoOn = true
			self.generarTrazoRapido(self.posicionAnterior().up(1))
	}
}