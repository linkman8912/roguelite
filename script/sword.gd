extends Node2D

var rot_speed = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_sword(speed,offset,dammage):
	var attack_node = get_node_or_null("Sword/attack_node")
	if attack_node:
		attack_node.set_damage(dammage)
	rot_speed = speed
	$Sword.position.y = offset * -1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate( rot_speed * delta)

func set_rot_speed(rot):
	rot_speed = rot
