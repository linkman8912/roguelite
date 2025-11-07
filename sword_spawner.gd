extends Node
var sword_id = "sword"
@onready var sword_node = null
var sword_scene = load("res://scene/sword.tscn")
var attack_node = null
var attack = 0
var attack_speed = 10
var sword_length = 50
func _ready() -> void:
	spawn_sword(200)
	s()
	set_sword()
	


func s():
	attack_node = get_parent().get_node_or_null("attack_node")
	if attack_node:
		attack = attack_node.attack_points()
		attack_speed = attack_node.attack_speed()
		sword_length = attack_node.get_length()
		print("sword set: ",attack_speed)

func set_sword():
	s()
	await get_tree().create_timer(0.2).timeout
	sword_node.set_sword(sword_length,attack_speed,50,attack)


#func _process(delta: float) -> void:
	#if sword_node:
		#set_sword()
		#sword_node.set_sword(sword_length,attack_speed,150,attack)

func spawn_sword(offset):
	sword_node = sword_scene.instantiate()
	add_child(sword_node)
	set_sword()
	sword_node.set_sword(sword_length,attack_speed,offset,attack)
	sword_node.name = sword_id
	#print("sword spawn")
