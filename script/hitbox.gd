extends Area2D
#print("Collided with: ", collider.name)
@onready var main = get_parent().get_parent()
@onready var player = main.get_node_or_null("Player")
@onready var enemy = main.get_node_or_null("Enemy")
@onready var parent = self.get_parent()
@onready var sword = get_parent().get_parent()
@onready var sound_node = $AudioStreamPlayer
var pitch = 1
var hit_sound = load("res://aduio/hit3.wav")
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
			print("lk: ",speed)
			mat.set_shader_parameter("show_white", false) # back to normal

var hit_stop = 1.0
func slow():
	
	get_tree().paused = true
	await get_tree().create_timer(hit_stop*0.05).timeout
	get_tree().paused = false

func randi_sound(r,p):
	if p:
		return "res://aduio/parry"+ str(r) + ".wav"
	else:
		return "res://aduio/hit"+ str(r) + ".wav"

func _on_area_entered(area: Area2D) -> void:
	var collider = area.get_parent() # often the main node that owns the area
	var attack_node = collider.get_node_or_null("attack_node")
	#print("sword2: ",sword.name)=
	if sword.name == "sword":
		sword.switch()
		print("sams ")
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		sound_node.pitch_scale = rng.randf_range(0.1,2)
		var s_num = int(rng.randf_range(1,4))
		if self.name == "sword":
			hit_sound = load(randi_sound(s_num,true))
			
		else:
			hit_sound = load(randi_sound(s_num,false))
		sound_node.stream = hit_sound
		sound_node.play()
		await get_tree().create_timer(0.5).timeout


	if attack_node and (not( collider.name == "Player"  or  collider.name == "Enemy")):
		print(collider," :attacked")
		var attack = attack_node.attack_points()
		var speed = attack_node.attack_speed()
		damage(attack,speed)
		hit_stop = attack_node.attack_points()
		
		
		# Example assuming your sprite has this shader material
	
