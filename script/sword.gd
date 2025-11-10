extends Node2D

@onready var sword_sprite_node = get_node("Sword/sword_extender")
var rot_speed = 10
var dir = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_sword(10,10,10,0)

func set_sword(length,speed,offset,dammage):
	var attack_node = get_node_or_null("Sword/attack_node")
	if attack_node:
		attack_node.set_damage(dammage)
	rot_speed = speed
	$Sword.position.y = offset * -1
	sword_sprite_node.set_segment(length)
	
func switch():
	dir *= -1

func _process(delta: float) -> void:
	rotate( float(rot_speed*dir) * delta)
