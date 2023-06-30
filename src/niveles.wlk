import wollok.game.*
import juego.*
import escenario.*
import jugador.*
import direcciones.*
import visuales.*
import moto.*
import powerup.*

object nivel1 {
	const board = new BoardGround(image= "fondotierra.png")
	const property pinchos = []
	const player1 = new Player(numero=1, position = game.at(1,9))
	const player2 = new Player(numero=2, position = game.at(17,9))
	
	const powerDeP1 = new PowerupGuardado(position = game.at(4,9), powerupAgarrado = "vacio")
	const powerDeP2 = new PowerupGuardado(position = game.at(16,9), powerupAgarrado = "vacio")
	
	const jugador1 = new Jugador(moto=crearJugadores.crearMoto(crearJugadores.tipoDeMotoP1()), vida= crearJugadores.crearVida(2), bolsilloParaPoder = powerDeP1)
	const jugador2 = new Jugador(moto=crearJugadores.comprobarMismaMoto(), vida= crearJugadores.crearVida(18), bolsilloParaPoder= powerDeP2)

	method empezar(){
		game.addVisual(board)
		self.dibujarMuros()
		self.agregarJugadores()
		self.configuracionTeclado()
		self.dibujarPinchos()
		game.onTick(1000, "pinchos", {pinchos.forEach({p => p.alternarEncendido()})} )
		game.onCollideDo(jugador1.moto(), { algo => algo.chocar(jugador1.moto())})
		game.onCollideDo(jugador2.moto(), { algo => algo.chocar(jugador2.moto())})
		game.onTick(jugador1.moto().velocidad(), "ALKORTE", {jugador1.moto().alcorte()})
		game.onTick(jugador2.moto().velocidad(), "ALKORTE", {jugador2.moto().alcorte()})
		game.onTick(3000, "GENERAR_PODER", {administradorPowerups.generar()})
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
		powerDeP1.agregarPowerupGuardado()
		powerDeP2.agregarPowerupGuardado()
		jugador1.jugadorEnemigo(jugador2)
		jugador2.jugadorEnemigo(jugador1)
		jugador1.moto().position(game.at(0,0))
		jugador2.moto().position(game.at(10,0))
		game.addVisual(jugador1.moto())
		game.addVisual(jugador2.moto())
	}
	
	method configuracionTeclado(){
		keyboard.a().onPressDo({jugador1.moto().moverSiPuede(izquierda,0)})
		keyboard.d().onPressDo({jugador1.moto().moverSiPuede(derecha,0)})
		keyboard.w().onPressDo({jugador1.moto().moverSiPuede(arriba,0)})
		keyboard.s().onPressDo({jugador1.moto().moverSiPuede(abajo,0)})
		keyboard.e().onPressDo({jugador1.usarPowerUp()})
		keyboard.left().onPressDo({ jugador2.moto().moverSiPuede(izquierda,0)})
		keyboard.up().onPressDo({jugador2.moto().moverSiPuede(arriba,0)})
	    keyboard.right().onPressDo({ jugador2.moto().moverSiPuede(derecha,0)})
	    keyboard.down().onPressDo({jugador2.moto().moverSiPuede(abajo,0)})
	    keyboard.control().onPressDo({jugador2.usarPowerUp()})
	}
	
	
}

