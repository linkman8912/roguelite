extends Node

@export var dammage = 0
@export var d_speed = 10
@export var length = 0

# Called when the node enters the scene tree for the first time.

func set_damage(d):
	print("dammage set")
	dammage = float(d)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func attack_points():
	return dammage

func set_d_speed(s):
	d_speed = s
	print("chud set:",d_speed)
func attack_speed():
	return d_speed
func set_length(l):
	length = l
func get_length():
	return length
