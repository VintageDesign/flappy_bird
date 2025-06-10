extends Node

@export var obstacle_scene: PackedScene

var player_start_pos = Vector2.ZERO
var obstacles = []

func _ready():
	$player.start_game.connect(on_start_game)
	
	player_start_pos.y = get_viewport().get_visible_rect().size.y/2
	player_start_pos.x = 50
	
	$player.position = player_start_pos

func on_start_game():
	$ObstacleSpawnTick.start()
	
func on_spawn_tick_expired():
	var offset = randf_range(0,25)
	var spacing_adjustment = randi_range(0, 15)
	var mob = obstacle_scene.instantiate()
	mob.position.y = get_viewport().get_visible_rect().size.y + offset
	mob.position.x = get_viewport().get_visible_rect().size.x + 32
	
	obstacles.append(mob)
	add_child(mob)
	
	mob = obstacle_scene.instantiate()
	mob.position.y = 0 + offset - spacing_adjustment
	mob.position.x = get_viewport().get_visible_rect().size.x + 32
	mob.rotation = PI
	
	obstacles.append(mob)
	add_child(mob)

func _on_player_hit() -> void:
	$ObstacleSpawnTick.stop()
	$player.position = player_start_pos
	for mob in obstacles:
		if mob != null:
			mob.queue_free()
	
	obstacles.clear()
