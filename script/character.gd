extends RigidBody2D

const maxDegreesPerSecond = 90





func _physics_process(delta: float) -> void:
	
	var maxRadians = deg_to_rad(maxDegreesPerSecond * delta)
	var directionx = Input.get_axis("ui_left", "ui_right")
	linear_velocity = linear_velocity.rotated(maxRadians * directionx)
	#print(rad_to_deg(directionx))
	"""var directionx = 0
	var directiony = 0
	directionx = Input.get_axis("ui_left", "ui_right")
	directiony = Input.get_axis("ui_down", "ui_up")
	if !(directionx == 0 && directiony == 0):
		var direction = Vector2(directionx, -directiony)
		#var anglediff = wrapf(velocity.angle() - direction.angle(), -PI, PI)
		var anglediff = wrapf(direction.angle() - linear_velocity.angle(), -PI, PI)
		var anglechange = clamp(anglediff, -maxRadians, maxRadians)
		linear_velocity = linear_velocity.rotated(anglechange)
		#print(rad_to_deg(anglediff))
	"""
	#print(velocity.length())
		#print(direction.normalized().angle() - velocity.normalized().angle())
		#velocity.x += direction * SPEED * 0.05 * delta
	
