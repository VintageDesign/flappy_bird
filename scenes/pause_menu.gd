extends CanvasLayer

signal hat_changed

func _ready():
	hide_all()

func _on_change_hat_pressed() -> void:
	$PauseMenu.hide()
	$HatMenu.show()

func hide_all():
	$HatMenu.hide()
	$PauseMenu.hide()


func _on_hat_menu_hat_changed(hat_selection) -> void:
	hat_changed.emit(hat_selection)


func _on_exit_pressed() -> void:
	get_tree().quit()
