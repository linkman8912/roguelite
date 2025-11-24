extends Button

# Reference to the stat manager - drag and drop in inspector
@export var stat_manager: Node
# Reference to the stat display for visual updates
@export var stat_display: VBoxContainer
# Which stat this button controls
@export var stat_type: String = "health" # Can be "health", "damage", "attack_speed", "speed", "max_health"
# How much to increase the stat by
@export var increment_amount: float = 1.0

func _ready():
	# Connect the button press signal
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	if stat_manager == null:
		return
	
	# Simple approach: just get current value and add increment
	var current_value = get_current_stat_value()
	var new_value = current_value + increment_amount
	
	
	# Call the appropriate stat manager method
	match stat_type:
		"health":
			stat_manager.set_health(new_value)
			# Wait a frame and verify the update
			await get_tree().process_frame
			var updated_value = get_current_stat_value()
		"damage":
			stat_manager.set_damage(new_value)
		"attack_speed":
			stat_manager.set_attack_speed(new_value)
		"speed":
			stat_manager.set_speed(new_value)
		"max_health":
			stat_manager.set_max_health(new_value)
		_:

func get_current_stat_value() -> float:
	match stat_type:
		"health":
			if stat_manager and stat_manager.health_node:
				return stat_manager.health_node.health
			else:
				return 0.0
		"damage":
			if stat_manager and stat_manager.attack_node and "damage" in stat_manager.attack_node:
				return float(stat_manager.attack_node.damage)
			return 0.0
		"max_health":
			if stat_manager and stat_manager.health_node:
				return stat_manager.health_node.max_health
			return 0.0
		_:
			return 0.0
