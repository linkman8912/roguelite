extends CharacterBody2D


const SPEED = 400.0
const slow = 10
func _ready():
	velocity = Vector2(-200,-200).normalized() * SPEED

func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity*delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
<<<<<<< HEAD





=======
	
	print(velocity.x)
>>>>>>> ca5d89b45817250692947ef005d6630ab4cf94ca
	if velocity.x >SPEED :
		velocity.x = move_toward(velocity.x, SPEED*1, slow)
	if velocity.x <SPEED*-1:
		velocity.x = move_toward(velocity.x, SPEED*-1, slow)
