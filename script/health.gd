extends Node
class_name Health

@export var max_health = 10
var health = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health=max_health 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("health:",health,get_parent())
func damage(attack):
	health -= attack
	if health <=0:
		get_parent().queue_free()

func set_health(s):
	health = float(s)

func set_max_health(s):
	max_health = float(s)
	print(max_health,"max_health")
