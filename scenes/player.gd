extends CharacterBody2D

@export var fall_accel = 75
@export var jump_impulse = 50

signal start_game

var target_velocity = Vector2.ZERO
var game_started = false

func _init():
	pass
	#$Camera2D. .screen_get_size()

func _physics_process(delta):
	
	if game_started:
		target_velocity.y = target_velocity.y + (fall_accel * delta)
	
		if Input.is_action_pressed("jump"):
			target_velocity.y = -1 * jump_impulse 
		
		velocity = target_velocity
		move_and_slide()
	else:
		if Input.is_action_pressed("jump"):
			game_started = true
			start_game.emit()
