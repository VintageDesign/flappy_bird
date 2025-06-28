extends Node


@export var obstacle_scene: PackedScene

var persistent_data = PersistentData.new()

var player_start_pos = Vector2.ZERO
var obstacles = []

enum {IN_GAME, PAUSED}
var game_state = IN_GAME

func _init():
	persistent_data.load()
	
func _input(_event):
	if Input.is_action_just_pressed("pause"):
		if game_state == PAUSED:
			print("Unpause")
			get_tree().paused = false
			game_state = IN_GAME
		else:
			print("Pause")
			get_tree().paused = true
			game_state = PAUSED
			

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
	var offset = randf_range(-25,25)
	var mob = obstacle_scene.instantiate()
	mob.position.y = get_viewport().get_visible_rect().size.y / 2 + offset
	mob.position.x = get_viewport().get_visible_rect().size.x + 32
	mob.score.connect(_on_score)
	mob.hit.connect(_on_player_hit)
	obstacles.append(mob)
	add_child(mob)  
	


func _on_score():
	$HUD.increment_score()

func _on_player_hit() -> void:
	$ObstacleSpawnTick.stop()
	
	$player.end_game()
	$player.position = player_start_pos
	
	
	if $HUD.get_score() > int(persistent_data.high_score):
		print("New High Score!")
		$HUD.set_high_score($HUD.get_score())
		persistent_data.high_score = $HUD.get_score()
		persistent_data.save()
	
	$HUD.reset_score()
	for mob in obstacles:
		if mob != null:
			mob.queue_free()
	obstacles.clear()
