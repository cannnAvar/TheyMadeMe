extends KinematicBody2D



export (float) var speed = 3000
export (float) var speedRun = 4000

var _random = RandomNumberGenerator.new()
var vec_to_player
var normalDay
var isHeThere = false
var stat = false
var _normalx
var _normaly
var legnth

var bload = load("res://Sahne/Actors/Bload.tscn")

func _ready() -> void:
	
	add_to_group("They")
	get_tree().call_group("Player", "set_enemy", self)




var player = null

func _physics_process(_delta):

	if player == null:
		return

	legnth = sqrt(pow(player.global_position.x - global_position.x, 2) + pow(player.global_position.y - global_position.y,2))

	if legnth <= 100:
		vec_to_player = player.global_position - global_position
		vec_to_player = vec_to_player.normalized() * speedRun * _delta
		look_at(vec_to_player)
		vec_to_player = move_and_slide(vec_to_player)

	if stat:
		normalDay = Vector2(_normalx * speed * _delta ,_normaly * speed * _delta)
	elif !stat:
		normalDay = Vector2(0,0)

	normalDay = move_and_slide(normalDay)


func random():
	_normalx = _random.randf_range(-2.0,1.0) 
	_normaly = _random.randf_range(-2.0,1.0)

func _on_Player_shootedEnemy() -> void:
	death()

 
func death():
	var bload_ins = bload.instance()
	get_tree().current_scene.add_child(bload_ins)
	bload_ins.global_position = global_position
	bload_ins.rotation = global_position.angle_to_point(player.global_position) 
	queue_free()

func set_player(p):
	player = p



func _on_Timer_timeout() -> void:
	print("hi")

	random()
	if legnth >= 100:
		stat = ! stat


func _on_Area2D_body_entered(_body: Node) -> void:
	if _body is KinematicBody2D:
		print_debug("hitdamage")
