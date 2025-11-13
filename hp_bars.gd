extends Control

@onready var e_hbar = $MarginContainer/HBoxContainer/TextureProgressBar
@onready var p_hbar = $MarginContainer/HBoxContainer2/TextureProgressBar
var stats = null

func p_set_health(min,max,value):
	p_hbar.min_value = min
	p_hbar.max_value = max
	p_hbar.value = value
func e_set_health(min,max,value):
	e_hbar.min_value = min
	e_hbar.max_value = max
	e_hbar.value = value

func _process(delta: float) -> void:
	var parent = get_parent().get_parent()
	if parent:
		var e_h_node = parent.get_node_or_null("Player/health_node")
		var p_h_node = parent.get_node_or_null("Enemy/health_node")
		stats = parent.get_stats()
		if p_h_node:
			var p_health = p_h_node.get_health()
			var health = stats["health"]
			p_set_health(0,health,p_health)
		else:
			p_set_health(0,0,0)
		if e_h_node:
			var e_health = e_h_node.get_health()
			var health = stats["health"]
			e_set_health(0,health,e_health)
			print(e_health,":health")
		else:
			e_set_health(0,10,0)
