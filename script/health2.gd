extends Node
class_name Health2
var sound = null
@onready var sound_node = get_node("audio_node")
@export var max_health = 10
#@onready var main = get_node("/root/Main")
var health = 0.0
var is_dead = false  # Prevent multiple death triggers

#func _ready():
	#set_max_health(main.stats["health"])
# Called when the node enters the scene tree for the first time.
func slow():
	get_parent()
	#set_max_health(main.stats["health"])
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("health:",health,get_parent())

func damage(attack):
	# Don't process damage if already dead
	if is_dead:
		return
		
	health -= attack
	
	if health <= 0 and not is_dead:
		is_dead = true
		
		# Determine sound based on who died
		if get_parent().name == "Player":
			sound = "lose"  # Player died
		else:
			sound = "win"   # Enemy died, player wins
		
		# Play death sound
		sound_node.play_sound(sound)
		
		# Stop the character from moving by calling the physics node
		var physics_node = get_node("../physics")
		if physics_node:
			physics_node.stop_movement()
		
		# Delete the sword completely to stop dealing damage
		var sword_spawner = get_node("../sword_spawner")
		if sword_spawner and sword_spawner.sword_node:
			sword_spawner.sword_node.queue_free()
			sword_spawner.sword_node = null  # Clear the reference
		
		# Stop processing for the parent
		get_parent().set_physics_process(false)
		get_parent().set_process(false)
		
		# Visual feedback - make character darker to show they died
		get_parent().modulate = Color(0.3, 0.3, 0.3, 1.0)
		
		# Wait 3 seconds so player can see who died
		await get_tree().create_timer(3.0).timeout
		
		# Then transition to next scene
		if get_parent().name == "Player":
			$"/root/Main".game_over()
		else:
			$"/root/Main".shop()
		
		# Clean up
		get_parent().queue_free()

func set_health(s):
	health = float(s)
	is_dead = false
	print("keys_h:",health)

func get_max_health():
	return max_health

func get_heath():
	return health

func set_max_health(s):
	max_health = float(s)
	health = max_health 
	is_dead = false
	print(max_health,"max_health")
