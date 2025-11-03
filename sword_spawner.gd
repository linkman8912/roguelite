extends Node
var sword_id = "sword"
@onready var sword_node = null
var sword_scene = load("res://scene/sword.tscn")
var attack_node = null
var attack = 0
var attack_speed = 10

func _ready() -> void:
	spawn_sword(200)

func set_sword():
	attack_node = get_parent().get_node_or_null("attack_node")
	if attack_node:
		attack = attack_node.attack_points()
		attack_speed = attack_node.attack_speed()
		
func _process(delta: float) -> void:
	if sword_node:
		set_sword()
		sword_node.set_sword(attack_speed,200,attack)

func spawn_sword(offset):
	sword_node = sword_scene.instantiate()
	add_child(sword_node)
	set_sword()
	sword_node.set_sword(attack_speed,offset,attack)
	sword_node.name = sword_id
	print("sword spawn")
