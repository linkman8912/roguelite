extends Node2D

var rot_speed = 1
var offset = 0
var dammage = 0
var speed = 0
@onready var parent_node = null
var parent_name = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#await get_tree().create_timer(0.1).timeout
	parent_node = get_parent().get_parent()
	print(parent_node)
	if parent_node:
		parent_name = parent_node.name
	#Console.add_command((parent_name+"_set_sword_speed"),set_sword_speed,1)
	#Console.add_command(parent_name+"_set_sword_offset",set_sword_offset,1)
	#Console.add_command(parent_name+"_set_sword_damage",set_sword_damage,1)


func set_sword_speed(s):
	set_sword(s,offset,dammage)
func set_sword_offset(o):
	set_sword(speed,o,dammage)
func set_sword_damage(d):
	set_sword(speed,offset,d)

func set_sword(s,o,d):
		offset = o
		dammage = d
		speed = s
		var attack_node = get_node_or_null("Sword/attack_node")
		if attack_node:
			attack_node.set_damage(float(dammage))
		rot_speed = float(speed)
		$Sword.position.y = float(offset) * -1
 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate( rot_speed * delta)

func set_rot_speed(rot):
	rot_speed = rot
