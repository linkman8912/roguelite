extends Node
class_name Health2

var sound = null
@onready var sound_node = get_node("audio_node")
@export var max_health = 10
var health = 0.0
# Called when the node enters the scene tree for the first time.


func slow():
	get_parent()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("health:",health,get_parent())
func damage(attack):
	if get_parent().name == "Player":
		sound = "win"
	else:
		sound = "lose"
	health -= attack
	if health <=0:
		sound_node.play_sound(sound)
		get_tree().paused = false
		#await get_tree().create_timer(10).timeout
		if get_parent().name == "Player":
			$"/root/Main".game_over()
		else:
			$"/root/Main".shop()
		get_parent().queue_free()

func set_health(s):
	health = float(s)
	print("keys_h:",health)

func get_max_health():
	return max_health
func get_heath():
	return health

func set_max_health(s):
	max_health = float(s)
	health = max_health 
	print(max_health,"max_health")
