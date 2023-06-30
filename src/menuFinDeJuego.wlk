import menu.*
import wollok.game.*

object finDelJuego inherits Menu {
	
	override method mostrar() {
		game.addVisual(self.board())
		self.agregarItem(volverAlMenu)
		self.agregarItem(salirDelJuego)
		game.addVisual(cursorFinDeJuego)
		self.configurarTeclado()
	}
	
	override method configurarTeclado() {
		keyboard.up().onPressDo({cursorFinDeJuego.subir()})
		keyboard.down().onPressDo({cursorFinDeJuego.bajar()})
		keyboard.enter().onPressDo({cursorFinDeJuego.seleccionActual().ejecutar()})
	}
	
}

object volverAlMenu inherits Eleccion {
	override method imagenElegida(){
		//return "imagen-fin-x.png"
		return "volver.png"
	}
	
	override method position() = game.at(7,7)
	
	override method ejecutar(){
		game.clear()
 		mainMenu.mostrar()
	}
}


object salirDelJuego inherits Eleccion {
	override method imagenElegida(){
		//return "imagen-fin-esc.png"
		return "quit.png"
	}
	
	override method position() = game.at(7,5)
	
	override method ejecutar(){
 		game.stop()
	}
}

object cursorFinDeJuego inherits Cursor(position = volverAlMenu.position().left(1), menu = finDelJuego){
}