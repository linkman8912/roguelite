extends Button

var stat_manager_node = null
var container_node = null
var player = null

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pressed.connect(_on_button_pressed)

	container_node = get_node("../../..")
	
func _on_button_pressed():
	#if stat_manager_node:
		#var current_health =  stat_manager_node.get_health()
		#stat_manager_node.set_health(current_health + 1)
	if container_node:
		container_node.start()

	return
