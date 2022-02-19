extends Node2D

onready var partical = $Particles2D


func _ready() -> void:
	partical.emitting = true

func _on_Timer_timeout() -> void:
	queue_free()
