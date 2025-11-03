extends VBoxContainer

@onready var health_display = $HealthHolder/health_display  
@onready var damage_display = $DamageHolder/damage_display

var health_node: Health
var damage = str(10)

func _ready():
	# Find the health node in the scene tree
	health_node = find_health_node()
	update_text()

func _process(delta):
	update_text()

func find_health_node() -> Health:
	# Look for a Health node in the parent or scene
	var parent = get_parent()
	while parent:
		for child in parent.get_children():
			if child is Health:
				return child
		parent = parent.get_parent()
	return null
	
func update_text():
	# Get health from the health node instead of hardcoded value
	if health_node:
		health_display.text = ("HEALTH = " + str(health_node.health))
	else:
		health_display.text = ("HEALTH = N/A")
	
	damage_display.text = ("DAMAGE = " + damage)
