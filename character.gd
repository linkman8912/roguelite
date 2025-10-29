extends CharacterBody2D


const SPEED = 400.0
const slow = 10
func _ready():
	pass
	
func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x += direction * SPEED * 0.05 * delta
