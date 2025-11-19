extends Node
class_name Health2
var sound = null
@onready var sound_node = get_node("audio_node")
@export var max_health = 10
#@onready var main = get_node("/root/Main")
var health = 0.0
var is_dead = false  # Prevent multiple death triggers

func _ready():
	
	# Hide the death particle on spawn
	var death_particle = get_node_or_null("../death_particle")
	if death_particle:
		death_particle.visible = false
		# Check if it's a GPUParticles2D or CPUParticles2D
		if death_particle is GPUParticles2D:
			death_particle.emitting = false
			death_particle.one_shot = true  # Make it play only once
		elif death_particle is CPUParticles2D:
			death_particle.emitting = false
			death_particle.one_shot = true  # Make it play only once

# Called when the node enters the scene tree for the first time.
func slow():
	get_parent()
	#set_max_health(main.stats["health"])
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("health:",health,get_parent())
	
func shake():
	print("shake")
	var parent = get_parent()
	var initial = parent.position 
	var duration = 2.25  # Total shake duration in seconds
	var elapsed = 0.0
	var shake_frequency = 45.0  # How fast it shakes (higher = faster)
	var max_intensity = 15.0  # Maximum shake distance
	
	# Use a smoother time step
	var time_step = 0.016  # Approximately 60 FPS
	
	while elapsed < duration:
		# Calculate intensity that grows over time (0 to 1)
		var progress = elapsed / duration
		var intensity = max_intensity * progress
		
		# Use sine waves for smooth oscillation
		var x_offset = sin(elapsed * shake_frequency) * intensity
		var y_offset = cos(elapsed * shake_frequency * 1.3) * intensity  # Different frequency for more organic feel
		
		# Apply shake offset
		parent.position = initial + Vector2(x_offset, y_offset)
		
		await get_tree().create_timer(time_step).timeout
		elapsed += time_step
	
	# Return to initial position smoothly
	var return_speed = 20.0
	while parent.position.distance_to(initial) > 0.1:
		parent.position = parent.position.move_toward(initial, return_speed)
		await get_tree().create_timer(time_step).timeout
	
	parent.position = initial


	
func damage(attack):
	var player_d = false
	var enemy_d = false
	# Don't process damage if already dead
	if is_dead:
		return
		
	health -= attack
	
	if health <= 0 and not is_dead and ((get_parent().name == "Player" and not enemy_d) or (get_parent().name == "Enemy" and not player_d)) :
		if get_parent().name == "Player":
			player_d = true
		if get_parent().name == "Enemy":
			enemy_d = true
		
		get_parent().get_node("hit_box_node").kill()
		shake()
		is_dead = true
		
		# Determine sound based on who died
		if get_parent().name == "Player":
			sound = "lose"  # Player died
			
			# Play death sound
			sound_node.play_sound("charging")
			
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
			
			
			# Wait before particle effect
			await get_tree().create_timer(2.25).timeout
			sound_node.play_sound("explode")
			
			# Play death particle for player (only once)
			var death_particle = get_node_or_null("../death_particle")
			if death_particle:
				death_particle.visible = true
				# Check particle type and emit
				if death_particle is GPUParticles2D:
					death_particle.one_shot = true  # Ensure one shot is set
					death_particle.emitting = true
				elif death_particle is CPUParticles2D:
					death_particle.one_shot = true  # Ensure one shot is set
					death_particle.emitting = true
			
			# Delete the sprite node "E"
			var sprite_node = get_node_or_null("../E")
			if sprite_node:
				sprite_node.queue_free()
			
			# Wait to see particle effect
			await get_tree().create_timer(0.75).timeout
			
			# Then transition to next scene
			$"/root/Main".game_over()
			
			# Clean up
			get_parent().queue_free()
			
		else:
			sound = "win"   # Enemy died, player wins
			
			# Play death sound
			sound_node.play_sound("charging")
			
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
			
			
			# Wait before particle effect
			await get_tree().create_timer(2.25).timeout
			sound_node.play_sound("explode")
			
			# Play death particle for enemy (only once)
			var death_particle = get_node_or_null("../death_particle")
			if death_particle:
				
				death_particle.visible = true
				# Check particle type and emit
				if death_particle is GPUParticles2D:
					death_particle.one_shot = true  # Ensure one shot is set
					death_particle.emitting = true
				elif death_particle is CPUParticles2D:
					death_particle.one_shot = true  # Ensure one shot is set
					death_particle.emitting = true
			
			# Delete the sprite node "E"
			var sprite_node = get_node_or_null("../E")
			if sprite_node:
				sprite_node.queue_free()
			
			# Wait to see particle effect
			await get_tree().create_timer(0.75).timeout
			
			# Then transition to next scene
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
