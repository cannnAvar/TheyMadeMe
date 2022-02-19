extends KinematicBody2D
var class_data

func _ready() -> void:
	class_data = load("res://Resources/Enemy.tres")

func _process(delta: float) -> void:
	death()

func death():
	if class_data.health <= 0:
		queue_free()

func _on_Player_shooted_enemy(_damage: int):
	class_data._take_damage(_damage)
