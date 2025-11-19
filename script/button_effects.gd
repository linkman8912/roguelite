extends Button
var sound_node

func _ready() -> void:
	pressed.connect(_on_button_pressed)
	sound_node = $audio_node
	
func _on_button_pressed():
	sound_node.play_sound("parry")
	return
