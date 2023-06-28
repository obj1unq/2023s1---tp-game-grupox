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


class Eleccion {
	
	method image() = self.imagenElegida()
	
	method imagenElegida()
	
	method position() = game.at(6,7)
	
	method ejecutar() {
		game.clear()
	}
}

object newGame inherits Eleccion {
	
	override method imagenElegida() {
		return "startGame.png"
	}
	
	override method position() = game.at(6,7)
	
	override method ejecutar() {
		super()
		eleccionDeMotos.mostrar()
		keyboard.r().onPressDo({
			game.clear()
			mainMenu.mostrar()
		})
	}
}

object eleccionDeMotos inherits Menu(board = new BoardGround(image = "eleccionFondo.jpg")) {
	
	override method mostrar() {
		game.addVisual(board)
		self.agregarItem(basica)
		game.addVisual(barraBasica)
		self.agregarItem(rapida)
		game.addVisual(barraRapida)
		self.agregarItem(explosiva)
		game.addVisual(barraExplosiva)
		game.addVisual(cursorEleccion)
		self.configurarTeclado()
	}
	
	override method configurarTeclado() {
		keyboard.s().onPressDo({cursorEleccion.bajar()})
		keyboard.w().onPressDo({cursorEleccion.subir()})
		keyboard.enter().onPressDo({cursorEleccion.seleccionActual().ejecutar()})
	}
	
}

object basica inherits Eleccion {
	
	override method imagenElegida() {
		return "motoBasicaAbajo.png"
	}
	
	override method ejecutar() {
		super()
		//falta creacion de moto para cada jugador
		nivel1.empezar()
	}
}

object rapida inherits Eleccion {
	
	override method imagenElegida() {
		return "motoRapidaAbajo.png"
	}
	
	override method position() = game.at(6,5)
	
	override method ejecutar() {
		super()
		//falta creacion de moto para cada jugador
		nivel1.empezar()
	}
}

object explosiva inherits Eleccion {
	
	override method imagenElegida() {
		return "motoExplosivaAbajo.png"
	}
	
	override method position() = game.at(6,3)
	
	override method ejecutar() {
		super()
		//falta creacion de moto para cada jugador
		nivel1.empezar()
	}
}

class Imagen {	
	method image() = self.imagenElegida()
	
	method imagenElegida()
	
	method position() = game.at(0,0)
}

object barraBasica inherits Imagen {
	override method imagenElegida() {
		return "barraBasica.png"
	}
	
	override method position() = basica.position().right(2)
}

object barraRapida inherits Imagen {
	
	override method imagenElegida() {
		return "barraRapida.png"
	}
	
	override method position() = rapida.position().right(2)
}

object barraExplosiva inherits Imagen {
	
	override method imagenElegida() {
		return "barraExplosiva.png"
	}
	
	override method position() = explosiva.position().right(2)
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
	var property position = game.at(0,0)
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

object cursorEleccion inherits Cursor(position = basica.position().left(1), menu = eleccionDeMotos){
}