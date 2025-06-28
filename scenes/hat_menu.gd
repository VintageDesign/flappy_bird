extends CanvasLayer


signal hat_changed

func _ready() -> void:
	$SpinnyHat/animation.play()
	$PartyHat/animation.play()

func _on_cowboy_hat_pressed() -> void:
	hat_changed.emit("cowboy_hat")


func _on_wizard_hat_pressed() -> void:
	hat_changed.emit("wizard_hat")



func _on_space_helmet_pressed() -> void:
	hat_changed.emit("space_helmet")


func _on_spinny_hat_pressed() -> void:
	hat_changed.emit("spinny_hat")

func _on_party_hat_pressed() -> void:
	hat_changed.emit("party_hat")

func _on_none_pressed() -> void:
	hat_changed.emit("none")
