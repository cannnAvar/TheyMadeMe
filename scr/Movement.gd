extends KinematicBody2D

export (float) var speed = 500

onready var raycast = $RayCast2D

func _ready() -> void:
	yield(get_tree(),"idle_frame")
	get_tree().call_group("They", "set_player",self)
var velocity = Vector2()

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

func _process(delta: float) -> void:
	get_input()
	look_at(get_global_mouse_position())

func _physics_process(delta: float) -> void:
	velocity = velocity.normalized() * speed * delta
	velocity = move_and_slide(velocity)


func fire():
	var coll = raycast.get_collider()
	if raycast.is_colliding() and coll.has_method("kill"):
		coll.kill()
