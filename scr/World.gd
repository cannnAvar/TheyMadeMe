extends Node2D

export var hit_effect: PackedScene

func generate_hit_effect(hit_position: Vector2)->void:
	var temp = hit_effect.instance()
	add_child(temp)
	temp.position = hit_position


func _on_Player_fire_shot(hit_pos: Vector2) -> void:
	generate_hit_effect(hit_pos)
