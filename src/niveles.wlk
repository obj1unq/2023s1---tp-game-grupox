import wollok.game.*
import juego.*
import escenario.*
import jugador.*
import direcciones.*
import visuales.*
import moto.*

object nivel1 {
	const board = new BoardGround(image = "tron_2.jpg")
	const property pinchos = []
	const jugador1 = new Jugador(moto=new MotoBasica(), vida = new Vida(position = game.at(2,9)))
	const jugador2 = new Jugador(moto=new MotoExplosiva(), vida = new Vida(position = game.at(18,9)))	
	const player1 = new Player(numero=1, position = game.at(1,9))
	const player2 = new Player(numero=2, position = game.at(17,9))
	
	method empezar(){
		self.dibujarMuros()
		self.agregarJugadores()
		self.configuracionTeclado()
		self.dibujarPinchos()
		game.onTick(1000, "pinchos", {pinchos.forEach({p => p.alternarEncendido()})} )
		game.onCollideDo(jugador1.moto(), { algo => algo.chocar(jugador1.moto())})
		game.onCollideDo(jugador2.moto(), { algo => algo.chocar(jugador2.moto())})
		//game.onTick(jugador1.moto().velocidad(), "ALKORTE", {jugador1.moto().alcorte()})
		game.onTick(jugador2.moto().velocidad(), "ALKORTE", {jugador2.moto().alcorte()})
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
	
	method agregarJugadores(){
		jugador1.vida().agregarVida()
		jugador2.vida().agregarVida()
		player1.agregarPlayer()
		player2.agregarPlayer()
		jugador1.jugadorEnemigo(jugador2)
		jugador2.jugadorEnemigo(jugador1)
		jugador1.moto().position(game.at(0,0)) // CORREGIR URGENTE 
		jugador2.moto().position(game.at(10,0))
		game.addVisual(jugador1.moto())//TAMBIEN CORREGIR
		game.addVisual(jugador2.moto())
	}
	
	method configuracionTeclado(){
		keyboard.a().onPressDo({jugador1.moto().moverSiPuede(izquierda,0)})
		keyboard.d().onPressDo({jugador1.moto().moverSiPuede(derecha,0)})
		keyboard.left().onPressDo({ jugador2.moto().moverSiPuede(izquierda,0)})
	    keyboard.right().onPressDo({ jugador2.moto().moverSiPuede(derecha,0)})
	    keyboard.up().onPressDo({ jugador2.moto().moverSiPuede(arriba,0)})
	    keyboard.down().onPressDo({ jugador2.moto().moverSiPuede(abajo,0)})
	}
	
	method volverAEmpezar(){
		game.clear()
		self.empezar()
		game.onTick(jugador2.moto().velocidad(), "ALKORTE", {jugador2.moto().alcorte()})
	}
}

