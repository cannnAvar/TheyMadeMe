extends Resource
class_name Entity

export (int) var health = 100
export (int) var strenght = 10
export (float) var speed = 500


func _take_damage(Damage : float = 10):
	self.health -= Damage
