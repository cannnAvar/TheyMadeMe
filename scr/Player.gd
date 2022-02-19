extends KinematicBody2D
var class_data

onready var raycast = $RayCast2D
signal fire_shot
signal shooted_enemy

var velocity = Vector2()


func _ready() -> void:
	class_data = load("res://Resources/Player.tres")

func get_input():
	velocity = Vector2()

	if Input.is_action_pressed("Right"):
		velocity.x += 1
	if Input.is_action_pressed("Left"):
		velocity.x -= 1
	if Input.is_action_pressed("Down"):
		velocity.y += 1
	if Input.is_action_pressed("Up"):
		velocity.y -= 1

	if Input.is_action_just_pressed("Fire"):
		print_debug(class_data.health)
		fire()

func _process(_delta: float) -> void:
	get_input()
	look_at(get_global_mouse_position())

	if class_data.health <= 0:
		death()

func _physics_process(delta: float) -> void:
	velocity = velocity.normalized() * class_data.Speed  * delta
	velocity = move_and_slide(velocity)

func death():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

func fire():
	if raycast.is_colliding():
		emit_signal("fire_shot", raycast.get_collision_point())
		emit_signal("shooted_enemy", class_data.strenght)
