import wollok.game.*

object screen {
	
	method validarPuedeIr(position) {
		if (not self.puedeIr(position)) {
			self.error("No puedo ir ahí")
		}
	}

	method dentro(position) {
		return position.x().between(0, game.width()-1) and
				position.y().between(0, game.height()-1)
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
object arriba  {
	
	method proxima(objeto, cantidad) {
		return objeto.position().up(cantidad)
	}
	
	method mover(objeto, cantidad) {
		self.validarMover(objeto,cantidad)
		screen.mover(objeto, self.proxima(objeto, cantidad))
	}
	
	method puedeMover(objeto, cantidad) {
		return screen.puedeIr(self.proxima(objeto, cantidad))
	}
	
	method validarMover(objeto, cantidad) {
		screen.validarPuedeIr(self.proxima(objeto, cantidad))
	}
		
}

object abajo {
	method proxima(objeto, cantidad) {
		return objeto.position().down(cantidad)
	}
	
	method mover(objeto, cantidad) {
		self.validarMover(objeto,cantidad)
		screen.mover(objeto, self.proxima(objeto, cantidad))
	}
	
	method validarMover(objeto, cantidad) {
		screen.validarPuedeIr(self.proxima(objeto, cantidad))
	}
	
	method puedeMover(objeto, cantidad) {
		return screen.puedeIr(self.proxima(objeto, cantidad))
	}
	
}

object izquierda {
	method proxima(objeto, cantidad) {
		return objeto.position().left(cantidad)
	}
	
	method mover(objeto, cantidad) {
		self.validarMover(objeto,cantidad)
		screen.mover(objeto, self.proxima(objeto, cantidad))
	}
	
	method validarMover(objeto, cantidad) {
		screen.validarPuedeIr(self.proxima(objeto, cantidad))
	}
	
	method puedeMover(objeto, cantidad) {
		return screen.puedeIr(self.proxima(objeto, cantidad))
	}
	
	
}

object derecha {
	
	method proxima(objeto, cantidad) {
		return objeto.position().right(cantidad)
	}
	
	method mover(objeto, cantidad) {
		self.validarMover(objeto,cantidad)
		screen.mover(objeto, self.proxima(objeto, cantidad))
	}
	
	method validarMover(objeto, cantidad) {
		screen.validarPuedeIr(self.proxima(objeto, cantidad))
	}
	
	method puedeMover(objeto, cantidad) {
		return screen.puedeIr(self.proxima(objeto, cantidad))
	}
	
			
}