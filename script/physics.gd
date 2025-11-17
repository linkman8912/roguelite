extends Node
class_name physics

@export var rigidBody : RigidBody2D # For assigning a RigidBody
@export_range(-1.0, 1.0, 2.0) var dir := 1.0 # Set the movement direction on start
const speedModifier = 20.0 # Set movement speed
var speed = 10 # speed stat
const slow = 10
var is_stopped = false # Flag to check if movement should be stopped

func _ready():
	if rigidBody:
		rigidBody.gravity_scale = 0
		rigidBody.linear_damp = -0.0
		rigidBody.angular_damp = 0
		#rigidBody.apply_impulse(Vector2(200, 200).normalized() * speed)
		rigidBody.linear_damp_mode = RigidBody2D.DAMP_MODE_REPLACE
		rigidBody.angular_damp_mode = RigidBody2D.DAMP_MODE_REPLACE
		
		#rigidBody.linear_velocity = Vector2(speed*speedModifier, speed*speedModifier)
		#rigidBody.velocity = Vector2(-200,-200).normalized() * speed
		#rigidBody.apply_impulse(Vector2(200, 200).normalized() * speed)

func _physics_process(delta: float) -> void:
	# Don't process physics if movement is stopped
	if is_stopped:
		return
		
	if rigidBody:
		var collision_info = rigidBody.move_and_collide(rigidBody.linear_velocity*delta, true)
		if collision_info && collision_info.get_collider().is_class("StaticBody2D"):
			#rigidBody.move_and_collide(rigidBody.linear_velocity*delta)
			rigidBody.linear_velocity = rigidBody.linear_velocity.bounce(collision_info.get_normal())
			#print(collision_info.get_collider())
			#(collision_info.get_collider().is_class("StaticBody2D"))
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
		#print(rigidBody.linear_velocity.length())

func _bounce(body: Node2D) -> void:
	if body:
		pass

func stop_movement():
	is_stopped = true
	if rigidBody:
		# Stop all velocity
		rigidBody.linear_velocity = Vector2.ZERO
		rigidBody.angular_velocity = 0
		# Optionally freeze the rigid body completely
		rigidBody.freeze = true

func resume_movement():
	is_stopped = false
	if rigidBody:
		# Unfreeze the rigid body
		rigidBody.freeze = false
		# Restore velocity if needed
		rigidBody.linear_velocity = Vector2(speed*speedModifier, speed*speedModifier)

func set_speed(s):
	speed = float(s)
	if not is_stopped:
		rigidBody.linear_velocity = Vector2(speed*speedModifier, speed*speedModifier)

func get_speed():
	return speed
