extends CharacterBody2D

@export var fall_accel = 300
@export var jump_impulse = 75

signal start_game
signal left_screen

var target_velocity = Vector2.ZERO
var game_started = false

func end_game():
	game_started = false
	

func _ready():
	$Hat.play("spinny_hat")
	

func _physics_process(delta):
	
	if game_started:
		target_velocity.y = target_velocity.y + (fall_accel * delta)
	
		if Input.is_action_pressed("jump"):
			target_velocity.y = -1 * jump_impulse 
			$PlayerBody.play("flight")
		
			
		
		velocity = target_velocity
		move_and_slide()
		

	else:
		if Input.is_action_pressed("jump"):
			game_started = true
			start_game.emit()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	left_screen.emit()

func _on_animated_sprite_2d_animation_looped() -> void:
	$PlayerBody.stop()
