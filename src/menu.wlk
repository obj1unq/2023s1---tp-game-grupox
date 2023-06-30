import wollok.game.*
import juego.*
import escenario.*
import niveles.*
import jugador.*
import visuales.*
import moto.*

class Menu {
	const property board = new BoardGround(image = "tron_2.jpg")
	const property objetosEnElMenu = []
	
	method elementoDelMenu(indice) = objetosEnElMenu.get(indice).position().left(1)
	
	method contieneMenu() = not objetosEnElMenu.isEmpty()

	method agregarItem(item){
		game.addVisual(item)
		objetosEnElMenu.add(item)
	}

	method mostrar()
	
	method configurarTeclado()
}

object mainMenu inherits Menu {
	
	override method mostrar() {
		game.addVisual(board)
		self.agregarItem(newGame)
		self.agregarItem(howTo)
		game.addVisual(cursorMenu)
		self.configurarTeclado()
	}
	
	override method configurarTeclado(){
		keyboard.s().onPressDo({cursorMenu.bajar()})
		keyboard.w().onPressDo({cursorMenu.subir()})
		keyboard.enter().onPressDo({cursorMenu.seleccionActual().ejecutar()})
	}
	
}

class Imagen {	
	method image() = self.imagenElegida()
	
	method imagenElegida()
	
	method position()
}

object imagenFinDeJuego {
	const property board = new BoardGround(image = "tron_2.jpg")
	
	method dibujarFinDeJuego(){
		game.addVisual(board)
		game.addVisual(self.jugadorGanador())
		game.addVisual(self.jugadorPerdedor())
	}
	
	method jugadorGanador(){
		return nivel1.jugadorGanador()
	}
	
	method jugadorPerdedor(){
		return nivel1.jugadorPerdedor()
	}
	
}



class Eleccion inherits Imagen {
	
	override method position() = game.at(6,7)
	
	method ejecutar() {
		game.clear()
	}
}

object newGame inherits Eleccion {
	
	override method imagenElegida() {
		return "startGame.png"
	}
	
	override method ejecutar() {
		super()
		eleccionDeMotosP1.mostrar()
		keyboard.r().onPressDo({
			game.clear()
			mainMenu.mostrar()
		})
	}
}

class EleccionDeMotos inherits Menu(board = new BoardGround(image = "eleccionFondo.jpg")) {
	const xGeneral = 2
	const xLogo = 12
	const player = "p1"
	const property basica = new SeleccionDeMoto (x=xGeneral,y=7,tipoDeMoto="Basica")
	const property rapida = new SeleccionDeMoto (x=xGeneral,y=5,tipoDeMoto="Rapida")
	const property explosiva = new SeleccionDeMoto (x=xGeneral,y=3,tipoDeMoto="Explosiva")
	const property barraBasica = new BarraStat (tipoDeMoto= "Basica", moto= self.basica())
	const property barraRapida = new BarraStat (tipoDeMoto= "Rapida", moto= self.rapida())
	const property barraExplosiva = new BarraStat (tipoDeMoto= "Explosiva", moto= self.explosiva())
	const property logo = new PlayerLogo (player= player, x=xLogo)
	const property cursor = cursorEleccionP1
	
	override method mostrar() {
		game.addVisual(self.board())
		game.addVisual(self.logo())
		self.agregarItem(self.basica())
		game.addVisual(self.barraBasica())
		self.agregarItem(self.rapida())
		game.addVisual(self.barraRapida())
		self.agregarItem(self.explosiva())
		game.addVisual(self.barraExplosiva())
		game.addVisual(self.cursor())
		self.configurarTeclado()
	}
	
	override method configurarTeclado() {
		keyboard.s().onPressDo({self.cursor().bajar()})
		keyboard.w().onPressDo({self.cursor().subir()})
		keyboard.space().onPressDo({self.accionAEjecutar()})
	}
	
	method accionAEjecutar() 

}

object eleccionDeMotosP1 inherits EleccionDeMotos {
	var property motoP1 = "x"
	
	override method accionAEjecutar() {
		motoP1 = self.cursor().seleccionActual().tipoDeMoto()
		crearJugadores.tipoDeMotoP1(motoP1)
		game.clear()
		eleccionDeMotosP2.mostrar()
		keyboard.r().onPressDo({
			game.clear()
			self.mostrar()
		})
	}
}

object eleccionDeMotosP2 inherits EleccionDeMotos(xGeneral=12, cursor = cursorEleccionP2, xLogo=2, player="p2") {
	var property motoP2 = "x"
	
	override method configurarTeclado() {
		keyboard.down().onPressDo({self.cursor().bajar()})
		keyboard.up().onPressDo({self.cursor().subir()})
		keyboard.enter().onPressDo({self.accionAEjecutar()})
	}	
	
	override method accionAEjecutar() {
		motoP2 = self.cursor().seleccionActual().tipoDeMoto()
		crearJugadores.tipoDeMotoP2(motoP2)
		game.clear()
		nivel1.empezar()
	}
	
}

class SeleccionDeMoto inherits Eleccion {
	const x = 0
	const y = 0
	const property tipoDeMoto = "x"
	
	override method imagenElegida() {
		return "moto" + self.tipoDeMoto() + "Abajo.png"
	}
	
	override method position() = game.at(x,y)
	
	override method ejecutar() {
	}
}

class BarraStat inherits Imagen {
	const property tipoDeMoto = "x"
	const property moto = "x"
	
	override method imagenElegida() {
		return "barra" + self.tipoDeMoto() + ".png"
	}
	
	override method position() = self.moto().position().right(2)
}

class PlayerLogo inherits Imagen {
	const property player = "x"
	const x = 0
	
	override method imagenElegida() {
		return self.player() + "logo.png"
	}
	
	override method position() = game.at(x,4)
}

object howTo inherits Eleccion {
	const fondo = new BoardGround(image = "INSTRUCCIONES PEDORRETAS.png")
	
	override method imagenElegida() {
		return "howToPlay.png"
	}
	
	override method position() = game.at(6,5)
	
	override method ejecutar() {
		super()
		game.addVisual(fondo)
		keyboard.r().onPressDo({
			game.clear()
			mainMenu.mostrar()
		})
	}
}

class Cursor {
	var index = 0
	var property position
	const property menu = null
	
	method image() = "cursor.png" 
	
	method finalDelMenu() = menu.objetosEnElMenu().size() - 1 
	
	method principioDelMenu() = 0 
	
	method seleccionActual() = game.getObjectsIn(self.position().right(1)).head()
	
	method bajar() {
		if (self.puedoBajar()) {
			index++
		} else {
			index = self.principioDelMenu()
		}
		self.position(menu.elementoDelMenu(index))
	}
	
	method subir() {
		if (self.puedoSubir()) {
			index-- 
		} else {
			index = self.finalDelMenu()
		}
		self.position(menu.elementoDelMenu(index))
	}
	
	method puedoSubir() {
		return index != self.principioDelMenu() and menu.contieneMenu()
	}
	
	
	method puedoBajar() {
		return index != self.finalDelMenu() and menu.contieneMenu()
	}
	
}

object cursorMenu inherits Cursor(position = newGame.position().left(1), menu = mainMenu){
}

object cursorEleccionP1 inherits Cursor(position = eleccionDeMotosP1.basica().position().left(1), menu = eleccionDeMotosP1){
}

object cursorEleccionP2 inherits Cursor(position = eleccionDeMotosP2.basica().position().left(1), menu = eleccionDeMotosP2){
}