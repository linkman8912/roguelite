extends Node
class_name Health

var die_sound = load("res://aduio/lose_aduio.mp3")
var win_sound = load("res://aduio/win_aduio.mp3")

var sound= die_sound
@onready var sound_node = get_parent().get_parent().get_node("AudioStreamPlayer")
@export var max_health = 10
var health = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health=max_health 

func slow():
	get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("health:",health,get_parent())
func damage(attack):
	if get_parent().name == "Player":
		sound = die_sound
	else:
		sound = win_sound
	health -= attack
	if health <=0:
		sound_node.stream = sound
		sound_node.play()
		#await get_tree().create_timer(10).timeout
		get_parent().queue_free()

func set_health(s):
	health = float(s)

func get_health():
	return health

func set_max_health(s):
	max_health = float(s)
	print(max_health,"max_health")
