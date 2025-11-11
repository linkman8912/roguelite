extends Area2D
#print("Collided with: ", collider.name)
@onready var main = get_parent().get_parent()
@onready var player = main.get_node_or_null("Player")
@onready var enemy = main.get_node_or_null("Enemy")
@onready var parent = self.get_parent()
@onready var sword = get_parent().get_parent()
@onready var sound = $AudioStreamPlayer
var hit_sound = load("res://aduio/jixaw-metal-pipe-falling-sound.mp3")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func damage(attack):
	var sprite = get_parent().get_node_or_null("E")
	var health_node = get_parent().get_node_or_null("health_node")
	slow()
	if health_node:
		health_node.damage(attack)
		if sprite:
			var mat = sprite.material
			mat.set_shader_parameter("show_white", true)  # switch to white
			await get_tree().create_timer(0.3).timeout
			mat.set_shader_parameter("show_white", false) # back to normal

var hit_stop = 1.0
func slow():
	
	get_tree().paused = true
	await get_tree().create_timer(hit_stop*0.1).timeout
	get_tree().paused = false
	#var physics_node = get_parent().get_node_or_null("physics")
	#if physics_node:
		#var speed  = physics_node.get_speed()
		#physics_node.set_speed(0)
		#await get_tree().create_timer(0.5).timeout
		#physics_node.set_speed(speed)

func _on_area_entered(area: Area2D) -> void:
	var collider = area.get_parent() # often the main node that owns the area
	var attack_node = collider.get_node_or_null("attack_node")
	#print("sword2: ",sword.name)=
	if sword.name == "sword":
		sword.switch()
		print("sams ")
		sound.stream = hit_sound
		sound.play()
	if attack_node and (not( collider.name == "Player"  or  collider.name == "Enemy")):
		print(collider," :attacked")
		var attack = attack_node.attack_points()
		damage(attack)
		hit_stop = attack_node.attack_points()
		
		
		# Example assuming your sprite has this shader material
	
