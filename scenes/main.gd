extends Node


@export var obstacle_scene: PackedScene

var persistent_data = PersistentData.new()

var player_start_pos = Vector2.ZERO
var obstacles = []

func _init():
	persistent_data.load()
	


func _ready():
	$HUD.set_high_score(persistent_data.high_score)
	$player.start_game.connect(on_start_game)
	$player.left_screen.connect(_on_player_hit)
	player_start_pos.y = get_viewport().get_visible_rect().size.y/2
	player_start_pos.x = 50
	
	$player.position = player_start_pos

func on_start_game():
	$ObstacleSpawnTick.start()
	
func on_spawn_tick_expired():
	var offset = randf_range(0,25)
	var spacing_adjustment = randi_range(0, 7)
	var mob = obstacle_scene.instantiate()
	mob.position.y = get_viewport().get_visible_rect().size.y + offset
	mob.position.x = get_viewport().get_visible_rect().size.x + 32
	
	mob.hit.connect(_on_player_hit)
	obstacles.append(mob)
	add_child(mob)  
	
	mob = obstacle_scene.instantiate()
	mob.position.y = 0 + offset - spacing_adjustment
	mob.position.x = get_viewport().get_visible_rect().size.x + 32
	mob.rotation = PI
	
	mob.hit.connect(_on_player_hit)
	obstacles.append(mob)
	add_child(mob)
	
	$HUD.increment_score()

func _on_player_hit() -> void:
	$ObstacleSpawnTick.stop()
	
	$player.end_game()
	$player.position = player_start_pos
	
	
	if $HUD.get_score() > persistent_data.high_score:
		print("New High Score!")
		$HUD.set_high_score($HUD.get_score())
		persistent_data.high_score = $HUD.get_score()
		persistent_data.save()
	
	$HUD.reset_score()
	for mob in obstacles:
		if mob != null:
			mob.queue_free()
	obstacles.clear()
