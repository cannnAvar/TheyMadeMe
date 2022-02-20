extends KinematicBody2D

onready var raycast = $RayCast2D
onready var animationPlayer = $AnimationPlayer
onready var swordAudio = $Sword/SwordAudio
onready var deadSound = $death
onready var timer = $Timer

var isAlive = true


signal shootedEnemy

export (float) var speed = 3000

var enemy
var velocity = Vector2()

func _ready() -> void:
	yield(get_tree(), "idle_frame")
	get_tree().call_group("They", "set_player", self)
	add_to_group("Player")
	

func set_enemy(p):
	enemy = p


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
		Attack()

func _process(_delta: float) -> void:
	get_input()
	look_at(get_global_mouse_position())


func _physics_process(delta: float) -> void:
	if isAlive: 
		velocity = velocity.normalized() * speed * delta
		velocity = move_and_slide(velocity)
	else:
		return



func Attack():
	if isAlive:
		animationPlayer.play("Sword Slash")
		if raycast.is_colliding():
			emit_signal("shootedEnemy")




func _on_Hurbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("hitbox"):
		isAlive = false
		deadSound.play()
		timer.start()
		get_tree().call_group("They", "set_player", null)


func _on_Timer_timeout() -> void:
	get_tree().reload_current_scene()
