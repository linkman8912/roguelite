extends CharacterBody2D


const SPEED = 400.0
const maxDegreesPerSecond = 90

func _ready() -> void:
	$sword_spawner.spawn_sword(10,150,1)
	
	
func _physics_process(delta: float) -> void:
	var maxRadians = deg_to_rad(maxDegreesPerSecond * delta)
	var directionx = Input.get_axis("ui_left", "ui_right")
	velocity = velocity.rotated(maxRadians * directionx)
	var directiony = 0
	directionx = Input.get_axis("ui_left", "ui_right")
	directiony = Input.get_axis("ui_down", "ui_up")
	if !(directionx == 0 && directiony == 0):
		var direction = Vector2(directionx, -directiony)
		#var anglediff = wrapf(velocity.angle() - direction.angle(), -PI, PI)
		var anglediff = wrapf(direction.angle() - velocity.angle(), -PI, PI)
		var anglechange = clamp(anglediff, -maxRadians, maxRadians)
		velocity = velocity.rotated(anglechange)
		#velocity.x += direction * SPEED * 0.05 * delta
	
