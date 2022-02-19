extends KinematicBody2D
var class_data



func _ready() -> void:
	class_data = load("res://Resources/Enemy.tres")
	add_to_group("They")

func _process(_delta: float) -> void:
	death()

var player = null

func _physics_process(_delta):
	if player == null:
		return
	var vec_to_player = player.global_position - global_position
	vec_to_player = vec_to_player.normalized() * class_data.speed * _delta
	look_at(vec_to_player)

	vec_to_player = move_and_slide(vec_to_player)
"""
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll.name == "Player":
			coll.kill()
"""
 


func _on_Player_shootedEnemy(damage) -> void:
	class_data._take_damage(damage)

 
func death():
	if class_data.health <= 0:
		queue_free()

func set_player(p):
	player = p



