extends Node
class_name physics
@export var rigidBody : RigidBody2D # For assigning a RigidBody
@export_range(-1.0, 1.0, 2.0) var dir := 1.0 # Set the movement direction on start
@export_range(100, 2000.0, 100.0) var speed := 400.0 # Set movement speed
const slow = 10
func _ready():
	if rigidBody:
		rigidBody.gravity_scale = 0
		rigidBody.linear_damp = -0.1
		rigidBody.angular_damp = 0
		rigidBody.apply_impulse(Vector2(200, 200).normalized() * speed)

		#rigidBody.velocity = Vector2(-200,-200).normalized() * speed
		#rigidBody.apply_impulse(Vector2(200, 200).normalized() * speed)

func _physics_process(delta: float) -> void:
	if rigidBody:
		var collision_info = rigidBody.move_and_collide(rigidBody.linear_velocity*delta, true)
		if collision_info && collision_info.get_collider().is_class("StaticBody2D"):
			#rigidBody.move_and_collide(rigidBody.linear_velocity*delta)
			rigidBody.linear_velocity = rigidBody.linear_velocity.bounce(collision_info.get_normal())
			print(collision_info.get_collider())
			print(collision_info.get_collider().is_class("StaticBody2D"))
		#else:
		#	rigidBody.move_and_collide(-rigidBody.linear_velocity*delta)

		#var direction := Input.get_axis("ui_left", "ui_right")
		#if direction:
		#	characterBody.velocity.x += direction * speed * 0.05
			

		#print(characterBody.velocity.x)
		#if characterBody.velocity.x > speed :
			#characterBody.velocity.x = move_toward(characterBody.velocity.x, speed * 2, slow)
		#if characterBody.velocity.x < speed * -1:
			#characterBody.velocity.x = move_toward(characterBody.velocity.x, speed * -2, slow)
func _bounce(body: Node2D) -> void:
	if body:
		pass
