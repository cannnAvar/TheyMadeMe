extends KinematicBody2D
var class_data

onready var raycast = $RayCast2D

export var bulletScene : PackedScene

signal fireShot
signal shootedEnemy

var velocity = Vector2()

func _unhandled_input(event):
	if (event.is_action_pressed("Fire")):
		var bullet = bulletScene.instance() as Node2D
		get_parent().add_child(bullet)
		bullet.global_position = self.global_position
		bullet.direction = global_position
		bullet.rotation = bullet.direction.angle()

func _ready() -> void:
	class_data = load("res://Resources/Player.tres")
	yield(get_tree(), "idle_frame")
	get_tree().call_group("They", "set_player", self)
	add_to_group("Player")
	

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
		fire()

func _process(_delta: float) -> void:
	get_input()
	look_at(get_global_mouse_position())

	if class_data.health <= 0:
		death()

func _physics_process(delta: float) -> void:
	velocity = velocity.normalized() * class_data.speed * delta
	velocity = move_and_slide(velocity)

func death():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()


func fire():
	if raycast.is_colliding():
		emit_signal("fireShot", raycast.get_collision_point())
		emit_signal("shootedEnemy", class_data.strenght)


