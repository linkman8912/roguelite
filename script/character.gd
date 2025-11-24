extends RigidBody2D

const maxDegreesPerSecond = 7
var control = 10

func set_control(c):
	control = float(c)

func _physics_process(delta: float) -> void:
	
	var maxRadians = deg_to_rad((maxDegreesPerSecond*control) * delta)
	var directionx = Input.get_axis("ui_left", "ui_right")
	linear_velocity = linear_velocity.rotated(maxRadians * directionx)
	
