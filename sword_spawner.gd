extends Node
var sword_id = "sword"
@onready var sword_node = null
var sword_scene = load("res://scene/sword.tscn")
var attack_node = null
var attack = 0
var attack_speed = 10
var sword_length = 50
var sword_offset = 50
var default_spawn_offset = 200  # Store the default offset for respawning

func _ready() -> void:
	spawn_sword(default_spawn_offset)
	s()
	set_sword()
	
func s():
	attack_node = get_parent().get_node_or_null("attack_node")
	if attack_node:
		attack = attack_node.attack_points()
		attack_speed = attack_node.attack_speed()
		sword_length = attack_node.get_length()
		print("sword set: ",attack_speed)

func set_sword():
	s()
	await get_tree().create_timer(0.2).timeout
	if sword_node:  # Check if sword still exists
		sword_node.set_sword(sword_length,attack_speed,sword_offset,attack)

#func _process(delta: float) -> void:
	#if sword_node:
		#set_sword()
		#sword_node.set_sword(sword_length,attack_speed,150,attack)

func spawn_sword(offset):
	sword_node = sword_scene.instantiate()
	add_child(sword_node)
	set_sword()
	sword_node.set_sword(sword_length,attack_speed,offset,attack)
	sword_node.name = sword_id
	#print("sword spawn")

# Delete the sword completely from the scene
func delete_sword():
	if sword_node:
		sword_node.queue_free()
		sword_node = null

# Respawn the sword (useful if you need to reset without reloading the scene)
func respawn_sword():
	# First make sure any existing sword is deleted
	delete_sword()
	# Wait a frame to ensure the old sword is gone
	await get_tree().process_frame
	# Spawn a new sword
	spawn_sword(default_spawn_offset)

# New function to properly disable the sword (kept for backward compatibility)
func disable_sword():
	if sword_node:
		sword_node.visible = false
		sword_node.set_physics_process(false)
		sword_node.set_process(false)
		# Disable any collision shapes in the sword
		for child in sword_node.get_children():
			if child is CollisionShape2D or child is CollisionPolygon2D:
				child.disabled = true
			elif child is Area2D or child is RigidBody2D or child is CharacterBody2D:
				child.set_physics_process(false)
				child.monitoring = false if child.has_property("monitoring") else child.monitoring
				child.monitorable = false if child.has_property("monitorable") else child.monitorable
