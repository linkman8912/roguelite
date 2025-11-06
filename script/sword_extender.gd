extends Node2D

@onready var hilt = $hilt
@onready var tip = $tip
@onready var mid_container= $mid_container
@onready var mid_container_load = load("res://scene/mid_container.tscn")
@onready var seg = load("res://scene/segment.tscn")
@export var segment_count: int = 50
@export var segment_width: float = 1.0
@export var x_offset_per_segment: float = -1.0
@export var y_offset_per_segment: float = -1.0

func  set_segment(s):
	segment_count = s
	set_sword()
func _ready() -> void:
	add_mid_container()
	set_sword()

func add_mid_container():
	var  mid_container = mid_container_load.instantiate()
	add_child(mid_container)
	
	

func set_sword():
	#🤳🤳🤳🤳
	#🤢🤢🤢🤢🤢🤢🤢🤢🤢🤢🤢🤢🤢🤢
	if mid_container:
		mid_container.queue_free()
		add_mid_container()
		var next_segment_x = 0.0
		var next_segment_y = 0.0

		for i in range(segment_count):
			var seg = seg.instantiate()
			mid_container.add_child(seg)
			seg.position = Vector2(next_segment_x, next_segment_y)
			next_segment_x += segment_width + x_offset_per_segment
			next_segment_y += y_offset_per_segment
			# Place the hilt at the start
			hilt.position = Vector2.ZERO
			tip.position=Vector2(next_segment_x,next_segment_y)
	# Spawn mid segments with offsets
	#var y_offset = 0.0
	#for i in range(segment_count):
	#	var seg = 
	#	mid_container.add_child(seg)
	#	seg.position = Vector2(x_offset, y_offset)
	#	x_offset += segment_width + x_offset_per_segment
	#	y_offset += y_offset_per_segment

	# Place the tip at the end
	#tip.position = Vector2(x_offset, y_offset)
