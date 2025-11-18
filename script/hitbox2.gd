extends Area2D
var battle
var player
var enemy
var parent
var sword
var sound_node
var pitch = 1
var hit_stop = 1
var hit_stop_duration = 0.03
var is_in_hitstop = false
static var global_hitstop_active = false

# Parry cooldown variables
var parry_cooldown_duration = 0.3
var can_parry = true
static var global_parry_cooldown = false

var shape_cast

func _ready():
	shape_cast = get_node_or_null("ShapeCast2D")
	
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
	if is_in_hitstop:
		Engine.time_scale = 1.0
		is_in_hitstop = false
		global_hitstop_active = false
	
	if not can_parry:
		can_parry = true
		global_parry_cooldown = false

func slow():
	if global_hitstop_active or is_in_hitstop:
		return
	
	is_in_hitstop = true
	global_hitstop_active = true
	
	var original_time_scale = Engine.time_scale
	Engine.time_scale = 0.05
	
	var scaled_duration = hit_stop_duration * clamp(hit_stop, 0.5, 2.0)
	await get_tree().create_timer(scaled_duration, false, true).timeout
	
	if is_inside_tree():
		Engine.time_scale = original_time_scale
		is_in_hitstop = false
		global_hitstop_active = false
	else:
		Engine.time_scale = 1.0
		global_hitstop_active = false

func start_parry_cooldown():
	if global_parry_cooldown:
		return
	
	can_parry = false
	global_parry_cooldown = true
	
	await get_tree().create_timer(parry_cooldown_duration, false, true).timeout
	
	if is_inside_tree():
		can_parry = true
		global_parry_cooldown = false

func damage(attack, speed):
	var sprite = get_parent().get_node_or_null("E")
	var health_node = get_parent().get_node_or_null("health_node")
	
	hit_stop = attack * 0.1
	
	if health_node:
		health_node.damage(attack)
		slow()
		
		if sprite:
			var mat = sprite.material
			mat.set_shader_parameter("show_white", true)
			await get_tree().create_timer(0.05 * speed).timeout
			mat.set_shader_parameter("show_white", false)

func randi_pitch():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	sound_node.pitch_scale = rng.randf_range(0.9, 1.0)

func _on_area_entered(area: Area2D) -> void:
	print("area entered: " + get_parent().name)
	print("area entered, collider: " + str(area.get_parent().name))

	var collider = area.get_parent()
	var attack_node = collider.get_node_or_null("attack_node")
	
	# Handle arena bounce
	if get_parent().name == "arena" and (collider.name == "Player" or collider.name == "Enemy"):
		print("bounce: ", collider)
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		sound_node.pitch_scale = rng.randf_range(0.8, 1.0)
		sound_node.play_sound("bounce")
		return
	
	# Handle sword collisions
	if sword.name == "sword" and collider.name != "arena":
		print("sword collision detected")
		randi_pitch()
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var s_num = int(rng.randf_range(1, 4))
		
		# Check if this is a sword-on-sword collision (PARRY)
		if collider.get_parent().name == "sword":
			# Check if parrying is allowed (not in cooldown)
			if can_parry and not global_parry_cooldown:
				sound_node.play_sound("parry")
				print("PARRY!")
				sword.switch()
				
				# Add hitstop for parries
				hit_stop = 0.5
				slow()
				
				# Start the parry cooldown
				start_parry_cooldown()
			else:
				# During cooldown, treat it as a regular hit
				sound_node.play_sound("hit" + str(s_num))
				print("parry on cooldown - regular hit")
		else:
			# Regular hit sound for non-sword collisions
			sound_node.play_sound("hit" + str(s_num))
			print("regular hit")
	
	# Handle damage to Player/Enemy from Sword
	if collider.name == "Sword" and (parent.name == "Player" or parent.name == "Enemy"):
		print(collider, " attacked ", parent.name)
		if attack_node:
			var attack = attack_node.attack_points()
			var speed = attack_node.attack_speed()
			hit_stop = clamp(attack * 0.1, 0.05, 0.3)
			damage(attack, speed)

# REMOVED: _process with ShapeCast2D - use Area2D signals only for consistency
# If you need ShapeCast2D for raycasting, keep it separate from collision detection
