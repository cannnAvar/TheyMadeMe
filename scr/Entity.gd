extends Resource
class_name Entity

export (int) var health = 100
export (int) var strenght = 10
export (float) var Speed = 500


func _take_damage(damage : float = 10):
	self.health -= damage
