import wollok.game.*

object juego {
	method configurar() {
		game.title("TRON")
		game.width(20)
		game.height(10)
	}
	
}


class BoardGround {
	const image 
	
	method image() = image
	
	method position() = game.origin()
}
