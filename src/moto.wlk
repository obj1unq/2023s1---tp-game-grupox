import wollok.game.*
import direcciones.*

object muerto {
	method iniciar() {
		game.say(moto,  "Choque")
		game.removeTickEvent("ALKORTE")
	}
	method puedeMover(){
		return false
	}
}

object vivo {
	method iniciar(){
		
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
	}
	
}
object moto {
	var property estado = vivo
	var property position = game.at(0,0)
	var property direccionApuntada  = arriba
	var property posicionAnterior = game.at(0,0)	
	method image() {
		return "Moto" + self.direccionApuntada().toString() + ".png"
	}
	
	method estado(){
		return estado
	}
	

	method estado(_estado){
		estado = _estado
		estado.iniciar()
	}
	
	method morir(){
		self.estado(muerto)
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
		}
	}

	method generarTrazo(){
		game.addVisual(new Trazo(position=self.posicionAnterior()))
	} 
	
	
	
}