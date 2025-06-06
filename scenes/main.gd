extends Node

@export var obstacle_scene: PackedScene

func _ready():
	$player.start_game.connect(on_start_game)
	var player_start_pos = Vector2.ZERO
	player_start_pos.y = get_viewport().get_visible_rect().size.y/2
	player_start_pos.x = 50
	
	$player.position = player_start_pos

func on_start_game():
	$ObstacleSpawnTick.start()
	
func on_spawn_tick_expired():
	var mob = obstacle_scene.instantiate()
	mob.position.y = get_viewport().get_visible_rect().size.y
	mob.position.x = get_viewport().get_visible_rect().size.x + 32
	
	
	add_child(mob)
	


		

	
