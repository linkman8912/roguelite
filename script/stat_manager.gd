extends Node

var attack_node = null
var health_node = null
var physics_node = null
var parent_node= null
var parent_name = ""
var sword_spawner = null
var front_stats = {
	"health": 10,
	"damage": 10,
	"playerSpeed": 10,
	"playerControl": 10,
	"weaponSpeed": 10,
	"weaponLength": 10,
	"luck": 10,
}
var stats = {
	"health": 10,
	"damage": 10,
	"playerSpeed": 10,
	"playerControl": 10,
	"weaponSpeed": 10,
	"weaponLength": 10,
	"luck": 10,
}
var stats_multiplier = {
	"health": 3,
	"damage": 1,
	"playerSpeed": 1,
	"playerControl": 1,
	"weaponSpeed": 1,
	"weaponLength": 5,
	"luck": 1,
}
func set_back_end_stats():
	for key in stats_multiplier.keys():
		stats[key] = stats_multiplier[key]*front_stats[key]
	#print("keys:" + str(stats))
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attack_node = get_parent().get_node_or_null("attack_node")
	health_node = get_parent().get_node_or_null("health_node")
	physics_node = get_parent().get_node_or_null("physics")
	parent_node = get_parent()
	sword_spawner = parent_node.get_node_or_null("sword_spawner")
	
	if parent_node:
		parent_name = parent_node.name +"_"
	Console.add_command((parent_name+"set_damage"),set_damage,1)
	Console.add_command(parent_name+"set_weapon_speed",set_weapon_speed,1)
	Console.add_command(parent_name+"set_health",set_health,1)
	Console.add_command(parent_name+"set_speed",set_speed,1)
	Console.add_command(parent_name+"set_max_health",set_max_health,1)
	Console.add_command(parent_name+"set_control",set_control,1)
	Console.add_command(parent_name+"set_weapon_length",set_weapon_length,1)

	apply_stats()

func slow():
	attack_node = get_parent().get_node_or_null("attack_node")
	health_node = get_parent().get_node_or_null("health_node")
	physics_node = get_parent().get_node_or_null("physics")
	parent_node = get_parent()
	sword_spawner = parent_node.get_node_or_null("sword_spawner")
	
	if parent_node:
		parent_name = parent_node.name +"_"
	apply_stats()

func _process(delta: float) -> void:
	set_back_end_stats()

func _kill():
	pass
	#print("is it nuvu pink")

func set_sword():
	sword_spawner.set_sword()

func get_attack_speed():
	if attack_node:
		return attack_node.attack_speed()
		set_sword()
func set_damage(d):
	#print("attack set tryed")
	if attack_node:
		#print("attack set",get_parent(), d)
		attack_node.set_damage(d)
		set_sword()
func set_weapon_speed(s):
	if attack_node:
		#print("attack speed set: ",s)
		attack_node.set_d_speed(s)
		set_sword()

func set_weapon_length(l):
	if attack_node:
		attack_node.set_length(l)
		set_sword()
func set_health(s):
	if health_node:
		health_node.set_health(s)
func set_max_health(s):
	if health_node:
		#print("health set",s)
		health_node.set_max_health(s)

func set_speed(s):
	if physics_node:
		#print("physics bitch",s)
		physics_node.set_speed(s)
func set_control(c):
	if(parent_node.name == "Player"):
		parent_node.set_control(c)
		
func set_stats(new_stats: Dictionary):
	if stats != new_stats:
		stats = new_stats
		apply_stats()
func set_front_stats(new_stats: Dictionary):
	if front_stats != new_stats:
		front_stats = new_stats
		apply_stats()

func get_stats():
	return stats
func get_front_stats():
	return front_stats

func apply_stats():
	set_back_end_stats()
	set_damage(stats["damage"])
	set_weapon_speed(stats["weaponSpeed"])
	set_max_health(stats["health"])
	set_speed(stats["playerSpeed"])
	set_control(stats["playerControl"])
	set_weapon_length(stats["weaponLength"])
	

func apply_card(rarity, card):
	pass
