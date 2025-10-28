extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -700.0
const DASH_VELOCITY = 1000
const SIDE_ACCEL = 120
const JUMP_POWER = 300
const MAX_DOWN_VEL = 500
const WALL_JUMP_POWER = 500
const WALLJUMP_TIME = 0.2
const DASHSPEED = SPEED * 5

 # Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = Input.get_axis("ui_left", "ui_right")
var walljumped = 0 # This is the direction of the walljump, between -1 and 1, -1 (and anything below -0.2) 
# being that a wall towards the right was walljumped off of and that the character should move to the left, 
# 1 (and anything above 0.2) being the opposite directon
# and 0 (or anything within 0.2 of 0 for bug reasons) being not walljumping. 
#It also acts as the timer for how long the walljump should last
# going down by a certain amount each frame.
var walljumpedLast = 0 # this variable is similar to walljumped in that it uses -1, 0, and 1 for left, right and off, 
# but it stores whatever the most recent walljump that occurs was so that you have to jump off a wall of the opposite side, 
# a workaround because I don't want to figure out the correct speed to move 
# so that you can't wallclimb on a single wall.
var oldYvelocity = 0
var walljumpY = 600
var walljumpX = 600
var hasDashed = 0
var dashState = false
var dashDirection = [0, 0]
var justWalljumped = false 
var wasDashing = false

# Node References 
@onready var rayCastLeftNode = $RayCastLeft
@onready var rayCastRightNode = $RayCastRight
@onready var dashTimer = $DashTimer
@onready var walljumpTimer = $WalljumpTimer

func _physics_process(delta):
	if wasDashing and not dashState:
		velocity.y = 0
		wasDashing = false
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_floor():
		walljumpedLast = 0
		hasDashed = false

	if Input.is_action_just_pressed("Dash") and hasDashed == false:
		dashDirection = get_direction()
		if dashDirection[0] != 0 or dashDirection[1] != 0:
			dashState = true
			hasDashed = true
			dashTimer.start()
			wasDashing = true

	# Handle jump.
	if Input.is_action_pressed("Jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
#		elif onWall == -1:
#			walljumped = 1
#		elif onWall == 1:
#			walljumped = -1 
		elif (rayCastLeftNode.is_colliding() or rayCastRightNode.is_colliding()) and walljumped == 0 and not is_on_floor():
			if rayCastLeftNode.is_colliding(): #and walljumpedLast != 1:
				velocity.y = -walljumpY
				walljumped = 1
				walljumpedLast = 1
				print("walljumped left")
			elif rayCastRightNode.is_colliding(): #and walljumpedLast != -1: # removed the check because the walljump doesn't actually give enough velocity to climb a single wall. 
				velocity.y = -walljumpY
				walljumped = -1
				walljumpedLast = -1
				print("walljumped right")
			walljumpTimer.start()
	direction = Input.get_axis("Left", "Right")
	# Get the input direction and handle the movement/deceleration.
	if walljumped != 0:
		if is_on_floor():
			walljumped = 0
		elif walljumped > 0.2:
			velocity.x = SPEED * 2
		elif walljumped < -0.2:
			velocity.x = SPEED * -2
		# elif walljumped > 0.5: # Slow down the walljump towards the end so that it's a bit more natural
			# walljumped -= 0.1
			# velocity.x = SPEED * (walljumped * 2)
		# elif walljumped < -0.5:
			# walljumped += 0.1
			# velocity.x = SPEED * (walljumped *  2)
		else:
			walljumped = 0
	elif dashState == true:
		# dashDirection = get_direction()
		# dashState = 1
		velocity.x = DASHSPEED * dashDirection[0]
		velocity.y = DASHSPEED * dashDirection[1] * -1
		print("dashDirection = " + str(dashDirection))
	elif direction:
		velocity.x = direction * SPEED
	else: 
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
func _ready():
	walljumped = 0

func get_direction():
	# dashDirection[0] = Input.get_axis("Left", "Right")
	# dashDirection[1] = Input.get_axis("Down", "Up") 
	return [Input.get_axis("Left", "Right"), Input.get_axis("Down", "Up")]


'''
func _on_area_2d_2_body_entered(body):
	if walljumpedLast != 1 and Input.is_action_pressed("ui_accept"):
		velocity.y -= 400
		velocity.x += 600
		walljumped = 1
		walljumpedLast = 1
		print("walljumped left")


func _on_area_2d_body_entered(body):
	if walljumpedLast != -1 and Input.is_action_pressed("ui_accept"):
		velocity.y = -walljumpY
		velocity.x = -walljumpX
		walljumped = -1
		walljumpedLast = -1
		print("walljumped right")


func _on_area_2d_3_body_entered(body):
	if walljumpedLast != 1 and Input.is_action_pressed("Jump"):
		velocity.y = -walljumpY
		velocity.x = walljumpX
		walljumped = 1
		walljumpedLast = 1
		print("walljumped left")  


func _on_walls_and_floors_collisions_body_entered(_body):
	print("help")
	if Input.is_action_pressed("Left"):
		onWall = -1
		print("left")
	elif Input.is_action_pressed("Right"):
		onWall = 1
		print("right")
	print("on wall")

func _on_walls_and_floors_collisions_body_exited(_body):
	onWall = 0
	print("off wall")
'''


func _on_walljump_timer_timeout() -> void:
	walljumped = 0


func _on_dash_timer_timeout() -> void:
	dashState = false
