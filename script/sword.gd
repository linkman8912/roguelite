extends Node2D

@onready var sword_sprite_node = get_node("Sword/sword_extender")
var rot_speed = 10
var dir = 1
var weapon = null 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_sword(10,10,10,0,"hammer")

func set_sword(length,speed,offset,dammage,type):
	weapon = type
	var attack_node = get_node_or_null("Sword/attack_node")
	if attack_node:
		attack_node.set_damage(dammage)
	rot_speed = speed
	$Sword.position.y = offset * -1
	sword_sprite_node.set_segment(length)
	

var t = 1
var accel = 1
func wepon_mov(delta):
	match weapon:
		"hammer":
			while t< rot_speed/5:
				t += 0.0001 * accel
				await get_tree().create_timer(0.1).timeout
				print("tn",t)
		"sword":
			t= 1
	

func slow():
	t = 1
	accel = 1

func switch():
	dir *= -1

func _process(delta: float) -> void:
	wepon_mov(delta)
	rotate( float(rot_speed*dir) * delta * t * accel) 
