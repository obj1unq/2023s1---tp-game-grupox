import wollok.game.*

//CREAR UNA SUPER CLASE DE ESCENARIOS PARA HERADR METHODOS 

class Muro {
	const property position 
	
	method image() = "muro.jpg"
	
	method esAtrevesable(){
		return false
	}
	//CORREGIR CON HERENCIA, POR AHORA PARA PROBAR FUNCIONALIDAD
	method chocar(moto){
		if(not self.esAtrevesable()){
		moto.morir()
		moto.enemigo().gane()
		}
	}
}

class Pincho { 
	const property position 
	var encendido = true 
	method image() = "pincho" + encendido.toString() + ".png"
	
	method esAtrevesable(){
		 return self.estaEncendido()
	}
	
	method estaEncendido(){
		return encendido
	}
	
	
	method alternarEncendido(){
		encendido = not encendido
	}
	method chocar(moto){
		if (self.estaEncendido()){
			moto.morir()
			moto.enemigo().gane()
		}
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
