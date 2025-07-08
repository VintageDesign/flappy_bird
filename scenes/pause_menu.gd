extends CanvasLayer

signal hat_changed
signal volume_changed

func _ready():
	hide_all()

func _on_change_hat_pressed() -> void:
	hide_all()
	$HatMenu.show()

func hide_all():
	$HatMenu.hide()
	$PauseMenu.hide()
	


func _on_hat_menu_hat_changed(hat_selection) -> void:
	hat_changed.emit(hat_selection)


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_volume_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		volume_changed.emit($PauseMenu/VolumeSlider.value)
