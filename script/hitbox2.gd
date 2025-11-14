extends Area2D
#print("Collided with: ", collider.name)
var battle
var player
var enemy
var parent
var sword
var sound_node
var pitch = 1

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



# Called every frame. 'delta' is the elapsed time since the previous frame.
func damage(attack,speed):
	var sprite = get_parent().get_node_or_null("E")
	var health_node = get_parent().get_node_or_null("health_node")
	print("file")
	slow()
	if health_node:
		health_node.damage(attack)
		if sprite:
			var mat = sprite.material
			mat.set_shader_parameter("show_white", true)  # switch to white
			await get_tree().create_timer(0.05*speed).timeout
			print("lk: ",speed)
			mat.set_shader_parameter("show_white", false) # back to normal
			

var hit_stop = 1.0
func slow():
	
	get_tree().paused = true
	await get_tree().create_timer(hit_stop*0.05).timeout
	get_tree().paused = false



func _on_area_entered(area: Area2D) -> void:
	var collider = area.get_parent() # often the main node that owns the area
	var attack_node = collider.get_node_or_null("attack_node")
	#print("sword2: ",sword.name)=
	print("nike",sword.name)
	if sword.name == "sword":
		sword.switch()
		print("sams ")
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		sound_node.pitch_scale = rng.randf_range(0,2)
		var s_num = int(rng.randf_range(1,5))
		if not collider.name == "Sword":
			sound_node.play_sound("hit"+str(s_num))
		else:
			print("swrodhitsword:",parent.name)
			sound_node.play_sound("parry")
		await get_tree().create_timer(0.5).timeout
	if collider.name == "game":
		print("cub")


	if attack_node and (not( collider.name == "Player"  or  collider.name == "Enemy")):
		print(collider," :attacked")
		var attack = attack_node.attack_points()
		var speed = attack_node.attack_speed()
		damage(attack,speed)
		hit_stop = attack_node.attack_points()
