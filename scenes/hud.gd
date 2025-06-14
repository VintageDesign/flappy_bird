extends CanvasLayer

var score = 0
const text_row_offset = Vector2.DOWN * 12


func _ready():
	var score_value_offset = Vector2.RIGHT * 70
	var high_score_value_offset = Vector2.RIGHT * 120
	$"Score Label".position = get_viewport().get_visible_rect().position
	$"Score value".position = get_viewport().get_visible_rect().position + score_value_offset
	$"High Score Label".position = get_viewport().get_visible_rect().position + text_row_offset
	$"High Score Value".position = get_viewport().get_visible_rect().position + text_row_offset + high_score_value_offset

func increment_score():
	score += 100
	$"Score value".text = str(score)

func reset_score():
	score = 0
	$"Score value".text = str(score)

func get_score():
	return score
	
func set_high_score(value):
	$"High Score Value".text = str(value)
