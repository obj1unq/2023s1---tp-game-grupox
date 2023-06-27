import wollok.game.*
import juego.*
import escenario.*
import jugador.*
import direcciones.*

object nivel1 {
	const board = new BoardGround(image = "tron_2.jpg")
	const jugador1 = new Jugador()
	const property pinchos = []
	//const jugador2 = new Jugador()
	
	method empezar(){
		self.dibujarMuros()
		self.agregarJugador()
		self.confiuracionTeclado()
		self.dibujarPinchos()
		game.onTick(1000, "pinchos", {pinchos.forEach({p => p.alternarEncendido()})} )
		game.onCollideDo(jugador1.moto(), { algo => algo.chocar(jugador1.moto())})
		game.onTick(200, "ALKORTE", {jugador1.moto().alcorte()})
	}
	
	method dibujarMuros(){
		const murosx1 = [1, 2, 17, 18]
		const murosx2 = [5, 14]
		const murosy1 = [2, 3, 6, 7]
		const murosy2 = [3, 4, 5, 6]
		self.dibujarMurosEnYeX(murosy1, murosx1)
		self.dibujarMurosEnYeX(murosy2, murosx2)
	}
	
	method dibujarPinchos(){
		const pinchosX1 = [7, 9, 11]
		self.dibujarPinchosEn(5, pinchosX1)
	}
	
	method dibujarPinchosEn(y, xs){
		xs.forEach({ x => 
			const p = new Pincho(position = game.at(x, y))
			game.addVisual(p) 
			pinchos.add(p)
		})
	}	
	
	
	method dibujarMurosEn(y, xs){
		xs.forEach({ x => game.addVisual(new Muro(position = game.at(x, y)))})
	}	
	
	method dibujarMurosEnYeX(ys, xs){
		ys.forEach({ y => self.dibujarMurosEn(y, xs)})
	}
	
	method agregarJugador(){
		//jugador1.jugadorEnemigo(jugador2)
		//jugador2.jugadorEnemigo(jugador1)
		jugador1.moto().position(game.at(9,0)) // CORREGIR URGENTE 
		game.addVisual(jugador1.moto())//TAMBIEN CORREGIR
	}
	
	method confiuracionTeclado(){
		keyboard.w().onPressDo({jugador1.moto().moverSiPuede(arriba, 0)})
		keyboard.s().onPressDo({jugador1.moto().moverSiPuede(abajo, 0)})
		keyboard.a().onPressDo({jugador1.moto().moverSiPuede(izquierda,0)})
		keyboard.d().onPressDo({jugador1.moto().moverSiPuede(derecha,0)})
	}
	
	
}

