extends CanvasLayer

var score = 0

func _ready():
	var score_value_offset = Vector2.RIGHT * 70
	$"Score Label".position = get_viewport().get_visible_rect().position
	$"Score value".position = get_viewport().get_visible_rect().position + score_value_offset
	
func increment_score():
	score += 100
	$"Score value".text = str(score)

func reset_score():
	score = 0
	$"Score value".text = str(score)
