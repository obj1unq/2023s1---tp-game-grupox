import moto.*

class Jugador {
	var vida = 3
	const property moto = new Moto()
	var property jugadorEnemigo  = null
		
	method restarVida(){
		vida -= 1	
	}
	
	method cantidadDeVidas(){
		return vida
	}
	
	method initialize(){
		moto.jugador(self)
	}
	
	method motoEnemiga(){
		return jugadorEnemigo.moto()
	}
	
	method puedeJugar(){
		return vida > 0
	}
	
	method validarSiPuedeJugar(){
		if(not self.puedeJugar()){
			self.error("No me quedan mas vidas para jugar")
		}
	}
	
}