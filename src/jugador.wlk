import moto.*

class Jugador {
	var property vida = 3
	const property moto = new Moto()
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