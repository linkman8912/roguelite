extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	print("BrysonPressed")
