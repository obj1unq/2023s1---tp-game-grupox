import mainMenu.*
import wollok.game.*

object finDelJuego inherits Menu {
	
	override method mostrar() {
		game.addVisual(board)
		self.agregarItem(volverAlMenu)
		self.agregarItem(salirDelJuego)
		game.addVisual(cursorMenu)
		self.configurarTeclado()
	}
	
	override method configurarTeclado() {
		keyboard.up().onPressDo({cursorMenu.subir()})
		keyboard.down().onPressDo({cursorMenu.bajar()})
		keyboard.enter().onPressDo({cursorMenu.seleccionActual().ejecutar()})
	}
	
}

object volverAlMenu inherits Eleccion {
	override method imagenElegida(){
		return "imagen-fin-x.png"
	}
	
	override method position() = game.at(5,7)
	
	override method ejecutar(){
 		mainMenu.mostrar()
	}
}


object salirDelJuego inherits Eleccion {
	override method imagenElegida(){
		return "imagen-fin-esc.png"
	}
	
	override method position() = game.at(5,5)
	
	override method ejecutar(){
 		game.stop()
	}
}

object cursorFinDeJuego inherits Cursor(position = volverAlMenu.position().left(1), menu = finDelJuego){
}