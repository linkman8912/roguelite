extends Node

@export var dammage = 0
@export var d_speed = 1

# Called when the node enters the scene tree for the first time.

func set_damage(d):
	dammage = d
func set_d_speed(s):
	d_speed = s
# Called every frame. 'delta' is the elapsed time since the previous frame.
func attack_points():
	return dammage
func attack_speed():
	return d_speed
