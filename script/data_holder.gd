extends HBoxContainer

var stats  = {
	"health": 1,
	"damage": 1,
	"playerSpeed": 5,
	"playerControl": 10,
	"weaponSpeed": 5,
	"weaponLength": 10,
	"luck": 10,
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func increase(stat: String, number: int):
	stats[stat] += number
func start():
	print("started")
	get_node("/root/Node2D").set_stats(stats)
	get_node("/root/Node2D").reset()
	print(stats)
