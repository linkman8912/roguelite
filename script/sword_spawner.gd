extends Node
var sword_id = "sword"
@onready var sword_node = get_node(sword_id)
var sword_scene = load("res://scene/sword.tscn")

func spawn_sword(rot_speed,offset,attack):
	var sword = sword_scene.instantiate()
	add_child(sword)
	sword.set_sword(rot_speed,offset,attack)
	sword.name = sword_id
