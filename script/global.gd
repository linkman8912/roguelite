extends Node

#stats
var stats = {
	"health": 10,
	"damage": 10,
	"playerSpeed": 10,
	"playerControl": 10,
	"weaponSpeed": 10,
	"weaponLength": 10,
	"luck": 10
}

@onready var shop_scene = load("res://scene/shop.tscn")
@onready var battle_scene = load("res://scene/battle.tscn")
@onready var start_scene = load("res://scene/start.tscn")

func shop():
	pass
	
func battle():
	reset()
	var instance = battle_scene.instantiate()
	add_child(instance)
	pass

func start():
	full_reset()
	var instance = start_scene.instantiate()
	add_child(instance)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func reset():
	for child in get_children():
		child.queue_free()

func full_reset():
	reset()
	for i in stats.keys():
		stats[i] = 10

func change_stat(stat, change):
	stats[stat] += change

func get_stats():
	return stats
