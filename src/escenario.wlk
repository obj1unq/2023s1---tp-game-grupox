import wollok.game.*

class Escenario{
	method chocar(moto){
		if(self.mensaje()){
		moto.morir()
		moto.enemigo().gane()
		}
	}
	method mensaje(){
		return true
	}
}

class Muro inherits Escenario{
	const property position 
	
	method image() = "muro.jpg"
	
	override method mensaje(){
		return true
	}
}

class Pincho inherits Escenario{ 
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
	
}
