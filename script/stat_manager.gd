extends Node

var attack_node = null
var health_node = null
var bounce_node = null
var parent_node= null
var parent_name = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attack_node = get_parent().get_node_or_null("attack_node")
	health_node = get_parent().get_node_or_null("health_node")
	bounce_node = get_parent().get_node_or_null("bounce")
	parent_node = get_parent()
	if parent_node:
		parent_name = parent_node.name +"_"
	Console.add_command((parent_name+"set_damage"),set_damage,1)
	Console.add_command(parent_name+"set_attack_speed",set_attack_speed,1)
	Console.add_command(parent_name+"set_health",set_health,1)
	Console.add_command(parent_name+"set_speed",set_speed,1)
	Console.add_command(parent_name+"set_max_health",set_max_health,1)

func set_damage(d):
	if attack_node:
		attack_node.set_damage(d)
func set_attack_speed(s):
	if attack_node:
		print("attack speed set")
		attack_node.set_d_speed(s)
func set_health(s):
	if health_node:
		health_node.set_health(s)
func set_max_health(s):
	if health_node:
		health_node.set_max_health(s)
func set_speed(s):
	if bounce_node:
		bounce_node.set_speed(s)
