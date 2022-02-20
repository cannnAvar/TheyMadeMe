extends Area2D

onready var audio = $AudioStreamPlayer2D
var scne = load("res://Sahne/end.tscn")

func _on_AudioStreamPlayer2D_finished() -> void:
	get_tree().change_scene(scne)


func _on_Goal_area_entered(area: Area2D) -> void:
	audio.play()
