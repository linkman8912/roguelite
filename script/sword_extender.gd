extends Node2D

@onready var hilt = $hilt
@onready var tip = $tip
@onready var mid_container= null
@onready var mid_container_load = load("res://scene/mid_container.tscn")
@onready var seg = load("res://scene/segment.tscn")
@export var segment_count: int = 10
@export var segment_width: float = 1.0
@export var x_offset_per_segment: float = -1.0
@export var y_offset_per_segment: float = -1.0
var length_threshold = 70
var offset_multiplier = 0.5

@onready var ball = get_node("../../../..")

func  set_segment(s):
	segment_count = int(s)
	set_sword()
func _ready() -> void:
	add_mid_container()
	set_sword()

func add_mid_container():
	mid_container = mid_container_load.instantiate()
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
			tip.position=Vector2(next_segment_x,next_segment_y - (tip.texture.get_size().y))
		print("sword hilt: " + str(hilt.position))
		print("sword tip: " + str(tip.position))
		var shape_cast = get_parent().get_node("hit_box_node").get_node("ShapeCast2D")
		var collision_shape = get_parent().get_node("hit_box_node").get_node("CollisionShape2D")
		
		#CLAUDE
		shape_cast.position = Vector2.ZERO
		collision_shape.position = Vector2.ZERO

		#var tip_top = (tip.position - tip.texture.get_size()/2)
		#var hilt_bottom = (hilt.position + hilt.texture.get_size()/2)
		#var tip_top = tip.position - (tip.texture.get_size()/2)
		#var tip_top = Vector2((tip.position - (tip.texture.get_size()/2)).x, tip.position.y)
		var tip_top = tip.position # CLAUDE

		#var hilt_bottom = hilt.position + (hilt.texture.get_size()/2)
		var hilt_bottom = hilt.position # CLAUDE


		#var new_position = (hilt_bottom + tip_top)/2
		##CLAUDE
		##var hitbox_height = abs(tip.position.y - hilt.position.y)
		##var new_position = Vector2(0, (tip.position.y + hilt.position.y) / 2 - hitbox_height/2)
		
		#CLAUDE
		#var hitbox_height = abs(tip.position.y - hilt.position.y) / 2
		#var new_position = Vector2(0, (tip.position.y + hilt.position.y) / 2 - hitbox_height + (hilt.texture.get_size().y/2))
		#CLAUDE
		#var hitbox_height = abs(tip.position.y - hilt.position.y)
		#var new_position = Vector2(0, (tip.position.y + hilt.position.y) / 2 - hitbox_height * 0.45)
		
		#NEW
		#var new_position = Vector2(0, (tip.position.y + hilt.position.y) / 2 - segment_count * 0.45)

		
		# NEW
		#var hitbox_height = abs(tip.position.y - hilt.position.y) / 2
		#var new_position = Vector2(0, (tip.position.y + hilt.position.y) / 2)
		
		# NEW
		#var new_position = Vector2(0, (tip.position.y + hilt.position.y) / 2 + get_offset(segment_count))
		var new_position = Vector2(0, (tip.position.y + hilt.position.y) / 2)
		
		#var new_position = Vector2((hilt_bottom + tip_top).x, (hilt.position + tip_top).y)
		#var new_position = (hilt_bottom + tip_top)/2


		#shape_cast.position = ((hilt.position - hilt.texture.get_size()) + (tip.position + tip.texture.get_size()))/2
		#shape_cast.position = ((hilt.position) + (tip.position - Vector2(0, tip.texture.get_size().y)))/2
		#collision_shape.position = ((hilt.position) + (tip.position - Vector2(0, tip.texture.get_size().y)))/2
		shape_cast.position = new_position
		collision_shape.position = new_position


		var rectangle = RectangleShape2D.new()
		#print("tip: " + str((tip.position - hilt.position).length()))
		#rectangle.size = Vector2(6, (tip.position - hilt.position).length())
		#rectangle.size = Vector2(6, (tip.position - hilt.position).length()/2)
		rectangle.size = Vector2(6, (tip_top - hilt_bottom).length()/2)


		shape_cast.set_shape(rectangle)
		collision_shape.set_shape(rectangle)
		
		print("segment_count: " + str(segment_count))
		print("segment_width: " + str(segment_width))
		print("y_offset_per_segment: " + str(y_offset_per_segment))
		print("total segments length: " + str(segment_count * y_offset_per_segment))
		print("tip texture height: " + str(tip.texture.get_size().y))
		print("hilt texture height: " + str(hilt.texture.get_size().y))

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

func get_offset(length):
	return (length - length_threshold) * offset_multiplier
