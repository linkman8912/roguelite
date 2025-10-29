extends CharacterBody2D


const SPEED = 400.0
func _ready():
	pass
	
func _physics_process(delta: float) -> void:
	var directionx := Input.get_axis("ui_left", "ui_right")
	var directiony := Input.get_axis("ui_down", "ui_up")
	if directionx && directiony:
		var direction = Vector2(directionx, directiony)
		print(velocity.normalized().angle() - direction.normalized().angle())
		#velocity.x += direction * SPEED * 0.05 * delta
