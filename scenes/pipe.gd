extends CharacterBody2D

@export var approach_speed = 50
signal hit

func _process(delta):
	velocity = Vector2.LEFT * approach_speed
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_collision(body: Node2D) -> void:
	hit.emit()
