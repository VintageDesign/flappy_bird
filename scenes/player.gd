extends CharacterBody2D

@export var fall_accel = 75
@export var jump_impulse = 50

signal start_game
signal hit

var target_velocity = Vector2.ZERO
var game_started = false

func end_game():
	game_started = false
	hit.emit()

func _init():
	pass
	

func _physics_process(delta):
	
	if game_started:
		target_velocity.y = target_velocity.y + (fall_accel * delta)
	
		if Input.is_action_pressed("jump"):
			target_velocity.y = -1 * jump_impulse 
		
		velocity = target_velocity
		move_and_slide()
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			if collision.get_collider() == null:
				continue
			if collision.get_collider().is_in_group("obstacles"):
				end_game()

	else:
		if Input.is_action_pressed("jump"):
			game_started = true
			start_game.emit()

	


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	end_game()
