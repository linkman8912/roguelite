extends Node
class_name bounce

@export var characterBody : CharacterBody2D # For assigning a Character Body
@export_range(-1.0, 1.0, 2.0) var dir := 1.0 # Set the movement direction on start
@export_range(100, 2000.0, 100.0) var speed := 400.0 # Set movement speed
const slow = 10
func _ready():
	if characterBody:
		characterBody.velocity = Vector2(-200,-200).normalized() * speed

func _physics_process(delta: float) -> void:
	if characterBody:
		var collision_info = characterBody.move_and_collide(characterBody.velocity*delta)
		if collision_info:
			characterBody.velocity = characterBody.velocity.bounce(collision_info.get_normal())

		#var direction := Input.get_axis("ui_left", "ui_right")
		#if direction:
		#	characterBody.velocity.x += direction * speed * 0.05
			

		#print(characterBody.velocity.x)
		if characterBody.velocity.x > speed :
			characterBody.velocity.x = move_toward(characterBody.velocity.x, speed * 2, slow)
		if characterBody.velocity.x < speed * -1:
			characterBody.velocity.x = move_toward(characterBody.velocity.x, speed * -2, slow)
		if characterBody.velocity.y > speed :
			characterBody.velocity.y = move_toward(characterBody.velocity.y, speed * 2, slow)
		if characterBody.velocity.y < speed * -1:
			characterBody.velocity.y = move_toward(characterBody.velocity.y, speed * -2, slow)
