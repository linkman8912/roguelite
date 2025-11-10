extends Area2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func damage(attack):
	var health_node = get_parent().get_node_or_null("health_node")
	if health_node:
		health_node.damage(attack)



func _on_area_entered(area: Area2D) -> void:
	var collider = area.get_parent() # often the main node that owns the area
	#print("Collided with: ", collider.name)
	var attack_node = collider.get_node_or_null("attack_node")
	var main = get_parent().get_parent()
	var player = main.get_node_or_null("Player")
	var enemy = main.get_node_or_null("Enemy")
	var parent = self.get_parent()
	var sprite = parent.get_node_or_null("E")
	var sword = get_parent().get_parent()
	#print("sword2: ",sword.name)
	if sword.name == "sword":
		sword.switch()
		print("sams ")

	if attack_node and (not collider == player or collider == enemy):
		print(get_parent()," :attacked")
		var attack = attack_node.attack_points()
		damage(attack)
		# Example assuming your sprite has this shader material
	
	if sprite:
		var mat = sprite.material
		mat.set_shader_parameter("show_white", true)  # switch to white
		await get_tree().create_timer(0.3).timeout
		mat.set_shader_parameter("show_white", false) # back to normal
