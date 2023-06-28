import moto.*

class Jugador {
	var property vida = 3
	const property moto = menu.eleccionDeMoto()
	var property jugadorEnemigo  = null
		
	method restarVida(){
		
	}
	
	method initialize(){
		moto.jugador(self)
	}
	
	method motoEnemiga(){
		return jugadorEnemigo.moto()
	}
	
}