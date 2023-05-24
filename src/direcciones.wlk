import wollok.game.*

object screen {

	method validarPuedeIr(position) {
		if (not self.puedeIr(position)) {
			self.error("No puedo ir ahÃ­")
		}
	}

	method dentro(position) {
		return position.x().between(0, game.width() - 1) and position.y().between(0, game.height() - 1)
	}

	method puedeIr(position) {
		return self.dentro(position)
	}

	method mover(objeto, position) {
		self.validarPuedeIr(position)
		objeto.position(position)
	}

}

//DIRECCIONES
class Direccion {

	method mover(objeto, cantidad) {
		self.validarMover(objeto, cantidad)
		screen.mover(objeto, self.proxima(objeto, cantidad))
	}

	method puedeMover(objeto, cantidad) {
		return screen.puedeIr(self.proxima(objeto, cantidad))
	}

	method validarMover(objeto, cantidad) {
		screen.validarPuedeIr(self.proxima(objeto, cantidad))
	}

	method proxima(objeto, cantidad) 
	
}

object arriba inherits Direccion {

	override method proxima(objeto, cantidad) {
		return objeto.position().up(cantidad)
	}

}

object abajo inherits Direccion {

	override method proxima(objeto, cantidad) {
		return objeto.position().down(cantidad)
	}

}

object izquierda inherits Direccion {

	override method proxima(objeto, cantidad) {
		return objeto.position().left(cantidad)
	}

}

object derecha inherits Direccion {

	override method proxima(objeto, cantidad) {
		return objeto.position().right(cantidad)
	}

}