import wollok.game.*
import moto.*
import visuales.*

class Jugador {
	var property vida
	//var property position = game.at(1,9)
	const property moto
	var property jugadorEnemigo  = null
	
	method cantidadDeVidas(){
		return vida.vidas()
	}
	
	method initialize(){
		moto.jugador(self)
	}
	
	method motoEnemiga(){
		return jugadorEnemigo.moto()
	}
	
	method perderVida(){
		vida.perderVida()
	}
	
}

object jugador1 inherits Jugador(moto=new MotoBasica(), vida = new Vida(position = game.at(2,9))){}

object jugador2 inherits Jugador(moto=new MotoExplosiva(), vida = new Vida(position = game.at(18,9))){}	