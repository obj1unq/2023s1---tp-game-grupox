import wollok.game.*

class Escenario {
	method mensaje() = true
	
	method chocar(moto) {
		if (self.mensaje()) {
			moto.morir()
		    moto.enemigo().gane()
	}
    }
}

class BoardGround inherits Escenario {
	
	const image 
	
	override method mensaje() = false
	
	method image() = image
	
	method position() = game.origin()
}

class Muro inherits Escenario {
	const property position 
	
	method image() = "muro.jpg"
	
}

class Pincho inherits Escenario { 
	const property position 
	var encendido = true 
	method image() = "pincho" + encendido.toString() + ".png"
	
	override method mensaje(){
		return encendido
	}
	
	method alternarEncendido(){
		encendido = not encendido
	}
}
class Trazo {
	
	var property position
	var property image = "trazo.png"
	
	method chocar(objeto){
		if(not objeto.estaProtegido()) {
			objeto.morir()
		objeto.enemigo().gane()
		}
	}
	
}
