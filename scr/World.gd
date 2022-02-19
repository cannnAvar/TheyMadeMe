extends Node2D

export var hitEffect: PackedScene


func generateEffect(hitPosition: Vector2, effect:PackedScene)->void:
	var temp = effect.instance()
	add_child(temp)
	temp.position = hitPosition


func _on_Player_fireShot(hitPos: Vector2) -> void:
	generateEffect(hitPos, hitEffect)
