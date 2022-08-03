object reserva {
	
	const habitats = []
	
	method agregarHabitat(h){
		habitats.add(h)
	}
	
	method habitatMasPoblado() = habitats.max{h=>h.cantidadVivos()}
	
	method biomasaTotal() = habitats.sum{h=> h.biomasa()}
	
	method algunHabitatEnEquilibrio() = 
		habitats.any{h=>h.enEquilibrio()}
	
	method estaEnTodos(especie) =
		habitats.all{h=>h.tieneAlgunoDe(especie)}
		
	method incendio() {
		habitats.forEach{h=>h.incendio()}
	}
}



class Habitat {
	
	const organismos = []
	
	method cantidadVivos() = organismos.count{o=>o.vivo()}
	
	method biomasa() = organismos.sum{o=>o.biomasa()}
	
	method enEquilibrio() = 
		self.cantidadGrandes() > self.cantidadVivos() / 3 &&
		self.cantidadVivos() > self.cantidadMuertos()
		
	method cantidadGrandes() = organismos.count{o=>o.grande()}
	
	method cantidadMuertos() = organismos.size() - self.cantidadVivos()
	
	method tieneAlgunoDe(especie) =
		organismos.any{o=>o.especie() == especie}
	
	method incendio() {
		organismos.forEach{o=>o.incendio()}
	}
		
	
}


class Organismo {
	
	var edad = 0
	const property especie 
	var property vivo = true
	
	method biomasa() =
		if (self.vivo())  
			self.biomasaVivo()
		else
			0
	
	method biomasaVivo() = edad
	

}

class Vegetal inherits Organismo{
	
	var altura = 1
	
	//override method biomasaVivo() = edad
	
	method grande() = altura >= 10
	
	method pequenio() = not self.grande() 
	
	method incendio() {
		if (self.grande())
			altura -= 5
		else
			vivo = false
	}
}

class Hongo inherits Organismo{
	
	method grande() = false
	override method biomasaVivo() = edad / 17 
	method incendio() { }
}


class Animal inherits Organismo{
	
	var peso = 10
	
	var locomocion = correr
	
	override method biomasaVivo() = peso + super()
	
	method grande() = peso > 60 && edad > 10
	
	method pequenio() = peso < 30
	
	method intermedio() = not self.grande() && not self.pequenio()
	
//	method incendio() {
//		peso = peso*0.9
//		if (not self.seSalva())
//			vivo = false
//	}
	
	method incendio() {
		peso = peso*0.9
		if (locomocion.seSalva(self))
			vivo = false
	}
	
	
//	method seSalva()
}

object correr {
	method seSalva(animal) =  animal.intermedio()
}

object volar {
	method seSalva(animal) = animal.grande()
}

object nadar {
	method seSalva(_) = true
}

object quieto {
	method seSalva(_) = false
}

//class AnimalVolador inherits Animal{
//	override method seSalva() = self.grande()
//}
//
//class AnimalNadador inherits Animal{
//	override method seSalva() = true
//}
//
//class AnimalQuieto inherits Animal{
//	override method seSalva() = false
//}
//
//class AnimalCorredor inherits Animal{
//	override method seSalva() = self.intermedio()
//}
//

