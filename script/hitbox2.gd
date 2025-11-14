extends Area2D

var battle
var player
var enemy
var parent
var sword
var sound_node
var pitch = 1
var hit_stop = 1
var hit_stop_duration = 0.1  # Base hitstop duration in seconds
var is_in_hitstop = false    # Prevent multiple hitstops from overlapping

func _ready():
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

func slow():
	# Prevent overlapping hitstops
	if is_in_hitstop:
		return
	
	is_in_hitstop = true
	
	# Store original time scales
	var original_time_scale = Engine.time_scale
	var original_physics_scale = Engine.physics_ticks_per_second
	
	# Apply time dilation instead of pausing (feels smoother)
	Engine.time_scale = 0.05  # 5% speed feels punchy
	
	# Duration scales with attack power for more impactful hits
	var scaled_duration = hit_stop_duration * clamp(hit_stop, 0.5, 2.0)
	
	# Use process-based timer instead of tree timer (more reliable during pause)
	await get_tree().create_timer(scaled_duration, true, false, true).timeout
	
	# Restore time scale
	Engine.time_scale = original_time_scale
	is_in_hitstop = false

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
			mat.set_shader_parameter("show_white", true)
			await get_tree().create_timer(0.05 * speed).timeout
			print("lk: ", speed)
			mat.set_shader_parameter("show_white", false)

func _on_area_entered(area: Area2D) -> void:
	var collider = area.get_parent()
	var attack_node = collider.get_node_or_null("attack_node")
	
	if get_parent().name == "arena" and (collider.name == "Player" or collider.name == "Enemy"):
		print("nike", collider)
	
	if sword.name == "sword" and (not collider.name == "arena"):
		sword.switch()
		print("sams ")
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		sound_node.pitch_scale = rng.randf_range(0.5, 2)
		var s_num = int(rng.randf_range(1, 5))
		
		if not collider.name == "Sword":
			sound_node.play_sound("hit" + str(s_num))
		else:
			sound_node.play_sound("parry")
			# Add hitstop for parries too (usually shorter)
			hit_stop = 0.5  # Lighter hitstop for parries
			slow()
		
		await get_tree().create_timer(0.01).timeout
	
	if collider.name == "Sword" and (parent.name == "Player" or parent.name == "Enemy"):
		print(collider, " :attacked")
		var attack = attack_node.attack_points()
		var speed = attack_node.attack_speed()
		
		# Calculate hit_stop based on attack power
		hit_stop = clamp(attack * 0.1, 0.05, 0.3)  # Min 0.05s, max 0.3s
		
		damage(attack, speed)
