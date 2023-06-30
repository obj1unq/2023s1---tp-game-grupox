import menu.*
import wollok.game.*
import niveles.*

object finDelJuego inherits Menu {
	
	override method mostrar() {
		game.addVisual(self.board())
		game.addVisual(self.imagenSalir())
		self.configurarTeclado()
	}
	
	override method configurarTeclado() {
		keyboard.x().onPressDo({game.stop})
	}
	
	method imagenSalir(){
		return "quit.png"
	}
	
}
