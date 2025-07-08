class_name PersistentData
extends Node

const save_file_location = "user://persistent_data.save"

var high_score = 0
var current_volume = 0


func _serialize():
	var file_dict = {
		"high_score": str(high_score),
		"current_volume": str(current_volume)
	}
	return file_dict
	

func _deserialize(file_dict):
	high_score = int(file_dict['high_score'])
	current_volume = float(file_dict['current_volume'])
	
	
func save():
	var save_file = FileAccess.open(save_file_location, FileAccess.WRITE)
	var data = _serialize()

	var json_string = JSON.stringify(data)

	save_file.store_line(json_string)

func load():
	if not FileAccess.file_exists(save_file_location):
		return # Error! We don't have a save to load.

	var save_file = FileAccess.open(save_file_location, FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()

		
		var json = JSON.new()

		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

	
		var node_data = json.data

		_deserialize(node_data)
