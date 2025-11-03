extends Node

@export var dammage = 0
@export var d_speed = 0

# Called when the node enters the scene tree for the first time.

func set_damage(d):
	print("dammage set")
	dammage = float(d)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func attack_points():
	return dammage

func set_d_speed(s):
	d_speed = s
func attack_speed():
	return d_speed
