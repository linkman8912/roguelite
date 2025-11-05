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

	if attack_node and (not collider == player or collider == enemy):
		print(attack_node.get_parent())
		var attack = attack_node.attack_points()
		damage(attack) 
