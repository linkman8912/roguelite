extends Area2D
var battle
var player
var enemy
var parent
var sword
var sound_node
var pitch = 1
var hit_stop = 1
var hit_stop_duration = 0.03  # Base hitstop duration in seconds
var is_in_hitstop = false    # Prevent multiple hitstops from overlapping
# Static variable to track global hitstop state
static var global_hitstop_active = false
# Parry cooldown variables
var parry_cooldown_duration = 0.3  # Cooldown duration in seconds
var can_parry = true              # Whether parrying is currently allowed
static var global_parry_cooldown = false  # Track parry cooldown globally

func _ready():
	# Reset time scale and hitstop state when scene loads
	Engine.time_scale = 1.0
	global_hitstop_active = false
	is_in_hitstop = false
	# Reset parry cooldown state
	can_parry = true
	global_parry_cooldown = false
	
	var sprite = get_parent().get_node_or_null("E")
	if sprite:
		var mat = sprite.material
		mat.set_shader_parameter("show_white", false)
	battle = get_parent().get_parent()
	player = battle.get_node_or_null("Player")
	enemy = battle.get_node_or_null("Enemy")
	parent = self.get_parent()
	sword = get_parent().get_parent()
	sound_node = $audio_node

func _exit_tree():
	# Clean up when node is removed from scene
	if is_in_hitstop:
		Engine.time_scale = 1.0
		is_in_hitstop = false
		global_hitstop_active = false
	# Reset parry cooldown on exit
	if not can_parry:
		can_parry = true
		global_parry_cooldown = false

func slow():
	# Check if ANY hitstop is already active globally
	if global_hitstop_active or is_in_hitstop:
		return
	
	is_in_hitstop = true
	global_hitstop_active = true
	
	# Store original time scale
	var original_time_scale = Engine.time_scale
	
	# Apply time dilation
	Engine.time_scale = 0.05  # 5% speed feels punchy
	
	# Duration scales with attack power for more impactful hits
	var scaled_duration = hit_stop_duration * clamp(hit_stop, 0.5, 2.0)
	
	# IMPORTANT: Use REAL time for the timer so it's not affected by time_scale
	await get_tree().create_timer(scaled_duration, false, true).timeout
	
	# Check if node still exists before restoring (in case scene changed)
	if is_inside_tree():
		Engine.time_scale = original_time_scale
		is_in_hitstop = false
		global_hitstop_active = false
	else:
		# Force cleanup if node was removed
		Engine.time_scale = 1.0
		global_hitstop_active = false

func start_parry_cooldown():
	# Check if parry cooldown is already active globally
	if global_parry_cooldown:
		return
	
	can_parry = false
	global_parry_cooldown = true
	
	# Wait for cooldown duration using real time
	await get_tree().create_timer(parry_cooldown_duration, false, true).timeout
	
	# Check if node still exists before resetting
	if is_inside_tree():
		can_parry = true
		global_parry_cooldown = false

func damage(attack, speed):
	var sprite = get_parent().get_node_or_null("E")
	var health_node = get_parent().get_node_or_null("health_node")
	print("file")
	
	# Set hit_stop value BEFORE calling slow()
	hit_stop = attack * 0.1  # Scale hitstop with attack damage
	
	if health_node:
		health_node.damage(attack)
		
		# Apply hitstop AFTER damage for better feel
		slow()
		
		if sprite:
			var mat = sprite.material
			mat.set_shader_parameter("show_white", true)  # switch to white
			await get_tree().create_timer(0.05 * speed).timeout
			print("lk: ", speed)
			mat.set_shader_parameter("show_white", false) # back to normal

func randi_pitch():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	sound_node.pitch_scale = rng.randf_range(0.9, 1.0)

func _on_area_entered(area: Area2D) -> void:
	var collider = area.get_parent() # often the main node that owns the area
	var attack_node = collider.get_node_or_null("attack_node")
	
	if get_parent().name == "arena" and (collider.name == "Player" or collider.name == "Enemy"):
		print("nike", collider)
		# Add pitch variation for bounce sound
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		sound_node.pitch_scale = rng.randf_range(0.8, 1.0)  # Subtle variation for bounce
		sound_node.play_sound("bounce")
	
	if sword.name == "sword" and (not collider.name == "arena"):
		sword.switch()
		print("sams ")
		randi_pitch()
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var s_num = int(rng.randf_range(1, 4))
		
		if not collider.name == "Sword":
			sound_node.play_sound("hit" + str(s_num))
		else:
			# Check if parrying is allowed (not in cooldown)
			if can_parry and not global_parry_cooldown:
				sound_node.play_sound("parry")
				print("parry")
				# Add hitstop for parries too (usually shorter)
				hit_stop = 0.5  # Lighter hitstop for parries
				slow()
				# Start the parry cooldown
				start_parry_cooldown()
			else:
				# During cooldown, treat it as a regular hit instead of parry
				sound_node.play_sound("hit" + str(s_num))
				print("parry on cooldown - regular hit")
		
		await get_tree().create_timer(0.01).timeout
	
	if collider.name == "Sword" and (parent.name == "Player" or parent.name == "Enemy"):
		print(collider, " :attacked")
		var attack = attack_node.attack_points()
		var speed = attack_node.attack_speed()
		
		# Calculate hit_stop based on attack power
		hit_stop = clamp(attack * 0.1, 0.05, 0.3)  # Min 0.05s, max 0.3s
		
		damage(attack, speed)
