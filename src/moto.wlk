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

class MotoBasica {
	var property estado = vivo
	var property position = game.at(0,0)
	var property direccionApuntada  = arriba
	var property posicionAnterior = game.at(0,0)	
	var property jugador = null
	const property velocidad = 300 //más baja = más rápido
	const property tipoDeMoto = "MotoBasica"
	
	const trazosGenerados = []
	var property estaProtegido = false
	
	method enemigo(){
		return jugador.motoEnemiga()
	}
	
	method generarTrazo(posicion){
		const nuevoTrazo = new Trazo(position= posicion)
		game.addVisual(nuevoTrazo)
		trazosGenerados.add(nuevoTrazo)
	} 
	

	method limpiarTrazos() {
		trazosGenerados.forEach({trazo => game.removeVisual(trazo)})
		trazosGenerados.clear()
	}
	
	method proteccionActivada() {
		estaProtegido = true
		game.schedule(2000, { estaProtegido = false })
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
	
}

class MotoRapida inherits MotoBasica(tipoDeMoto= "MotoRapida") {
	var property trazoOn = false
	
	override method velocidad() {
		return super() * 0.75
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

class MotoExplosiva inherits MotoRapida(tipoDeMoto= "MotoExplosiva") {
	
	override method velocidad() {
		return 250
	}
	
	override method generarTrazoRapido(posicion) {
		if (self.trazoOn() && self.apuntaHaciaArribaOAbajo()) {
			self.generarTrazo(self.posicionAnterior().left(1))
			self.generarTrazo(self.posicionAnterior().right(1))
			trazoOn = false
			} else if (self.trazoOn() && self.apuntaHaciaIzquierdaODerecha()) {
			self.generarTrazo(self.posicionAnterior().up(1))
			self.generarTrazo(self.posicionAnterior().down(1))
			trazoOn = false
			} else 
			trazoOn = true
	}
	
	method apuntaHaciaArribaOAbajo() {
		return direccionApuntada == arriba or direccionApuntada == abajo
	}
	
	method apuntaHaciaIzquierdaODerecha() {
		return direccionApuntada == izquierda or direccionApuntada == derecha
	}
	
}