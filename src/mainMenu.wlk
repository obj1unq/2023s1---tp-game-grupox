import wollok.game.*
import juego.*
import escenario.*
import niveles.*

object mainMenu {
	const board = new BoardGround(image = "tron_2.jpg")
	const property objetosEnElMenu = []
	
	method elementoDelMenu(indice) = objetosEnElMenu.get(indice).position().left(1)
	
	method contieneMenu() = not objetosEnElMenu.isEmpty()

	method agregarItem(item){
		game.addVisual(item)
		objetosEnElMenu.add(item)
	}
	
	method mostrar(){
		game.addVisual(board)
		self.agregarItem(newGame)
		self.agregarItem(howTo)
		game.addVisual(cursor)
		self.configurarTeclado()
	}
	
	method configurarTeclado(){
		keyboard.s().onPressDo({cursor.bajar()})
		keyboard.w().onPressDo({cursor.subir()})
		keyboard.enter().onPressDo({cursor.seleccionActual().ejecutar()})
	}
	
}

object newGame{
	
	method image() = "startGame.png"
	
	method position() = game.at(6,7)
	
	method ejecutar() {
		game.clear()

	nivel1.empezar()
	//selectorNiveles.mostrar()??
	}
	
}

object howTo {
	const fondo = new BoardGround(image = "INSTRUCCIONES PEDORRETAS.png")
	method image() = "howToPlay.png"
	
	method position() = game.at(6, 5)
	
	method ejecutar(){
		game.clear()
		game.addVisual(fondo)
		keyboard.r().onPressDo({
			game.clear()
			mainMenu.mostrar()
		})
	}

}

object cursor {
	var index = 0
	var property position = newGame.position().left(1)
	
	method image() = "cursor.png" 
	
	method finalDelMenu() = mainMenu.objetosEnElMenu().size() - 1 
	
	method principioDelMenu() = 0 
	
	method seleccionActual() = game.getObjectsIn(self.position().right(1)).head()
	
	method bajar() {
		if (self.puedoBajar()) {
			index++
		} else {
			index = self.principioDelMenu()
		}
		self.position(mainMenu.elementoDelMenu(index))
	}
	
	method subir() {
		if (self.puedoSubir()) {
			index-- 
		} else {
			index = self.finalDelMenu()
		}
		self.position(mainMenu.elementoDelMenu(index))
	}
	
	method puedoSubir() {
		return index != self.principioDelMenu() and mainMenu.contieneMenu()
	}
	
	
	method puedoBajar() {
		return index != self.finalDelMenu() and mainMenu.contieneMenu()
	}
	
}