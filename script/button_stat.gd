extends Button

var stat_manager_node = null
var container_node = null
var player = null

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pressed.connect(_on_button_pressed)

	if stat_manager_node:
		print(stat_manager_node.name)
	container_node = get_node("../../..")
	
func _on_button_pressed():
	print("+1 health")
	#if stat_manager_node:
		#var current_health =  stat_manager_node.get_health()
		#stat_manager_node.set_health(current_health + 1)
	if container_node:
		print(container_node,"+health")
		container_node.increase("health", 1)
		
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	##player = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node_or_null("Player")
	#player = get_node("/root").get_node_or_null("Node2D/Player")
	#print(player)#GeneralMenu/StatsMenu/Holder/HBoxContainer/MenuButtonHolder/Play/Button
	#if player:
		#print("statmanger called")
		#stat_manager_node = player.get_node_or_null("stat_manager")
