extends Node2D

@onready var sword_sprite_node = get_node("Sword/sword_extender")
var rot_speed: int = 10
var dir: int = 1
var moving: bool = false
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

func start():
	moving = true
func stop():
	moving = false

func _process(delta: float) -> void:
	if moving:
		var old_position = position
		rotate(float(rot_speed*dir) * delta)
		get_node("Sword/hit_box_node/ShapeCast2D").target_position = old_position
