extends CharacterBody2D


const SPEED = 400.0
const slow = 10
func _ready():
	velocity = Vector2(-200,-200).normalized() * SPEED

func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity*delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
		#velocity.x += SPEED

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x += direction * SPEED * 0.005
		

	print(velocity.x)
	if velocity.x >SPEED :
		velocity.x = move_toward(velocity.x, SPEED*2, slow)
	if velocity.x <SPEED*-1:
		velocity.x = move_toward(velocity.x, SPEED*-2, slow)
