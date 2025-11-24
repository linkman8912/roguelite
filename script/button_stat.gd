extends Button

var stat_manager_node = null
var container_node = null
var player = null

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pressed.connect(_on_button_pressed)

	container_node = get_node("../../..")
	
func _on_button_pressed():
	var name = get_parent().name 
	#if stat_manager_node:
		#var current_health =  stat_manager_node.get_health()
		#stat_manager_node.set_health(current_health + 1)
	if container_node:
		container_node.increase(name, 1)
		
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	##player = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node_or_null("Player")
	#player = get_node("/root").get_node_or_null("Node2D/Player")
	#if player:
		#stat_manager_node = player.get_node_or_null("stat_manager")
