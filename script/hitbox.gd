extends Area2D
@onready var main = get_parent().get_parent()
@onready var player = main.get_node_or_null("Player")
@onready var enemy = main.get_node_or_null("Enemy")
@onready var parent = self.get_parent()
@onready var sword = get_parent().get_parent()
@onready var sound_node = get_node("audio_node")
var pitch = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func damage(attack,speed):
	var sprite = get_parent().get_node_or_null("E")
	var health_node = get_parent().get_node_or_null("health_node")
	slow()
	if health_node:
		health_node.damage(attack)
		if sprite:
			var mat = sprite.material
			mat.set_shader_parameter("show_white", true)  # switch to white
			await get_tree().create_timer(0.05*speed).timeout
			mat.set_shader_parameter("show_white", false) # back to normal

var hit_stop = 1.0
func slow():
	
	get_tree().paused = true
	await get_tree().create_timer(hit_stop*0.05).timeout
	get_tree().paused = false



func _on_area_entered(area: Area2D) -> void:
	var collider = area.get_parent() # often the main node that owns the area
	var attack_node = collider.get_node_or_null("attack_node")
	if sword.name == "sword" and collider == "Sword":
		sword.switch()
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		sound_node.pitch_scale = rng.randf_range(0,2)
		var s_num = int(rng.randf_range(1,5))
		if not collider.name == "Sword":
			sound_node.play_sound("hit"+str(s_num))
		else:
			sound_node.play_sound("parry")
		await get_tree().create_timer(0.5).timeout


	if attack_node and (not( collider.name == "Player"  or  collider.name == "Enemy")):
		var attack = attack_node.attack_points()
		var speed = attack_node.attack_speed()
		damage(attack,speed)
		hit_stop = attack_node.attack_points()
		
		
		# Example assuming your sprite has this shader material
	
