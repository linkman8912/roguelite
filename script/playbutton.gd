extends Button

func _ready() -> void:
	pressed.connect(_on_button_pressed)

	
func _on_button_pressed():
	get_node("/root/Main").full_reset()
	get_node("/root/Main").shop()
	return
