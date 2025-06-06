extends Node



func _ready():
	var player_start_pos = Vector2.ZERO
	player_start_pos.y = get_viewport().get_visible_rect().size.y/2
	player_start_pos.x = 50
	
	$player.position = player_start_pos

	
