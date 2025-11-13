extends Node

@export var dammage = 0.0
var d_speed = 10
@export var length = 0

# Called when the node enters the scene tree for the first time.

func set_damage(d):
	dammage = float(d)
	

func attack_points():
	return dammage

func set_d_speed(a):
	d_speed = float(a)



func attack_speed():
	return d_speed
func set_length(l):
	length = l
func get_length():
	return length
