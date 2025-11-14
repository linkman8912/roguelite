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

var data = load_data()

func shop():
	reset()
	var instance = shop_scene.instantiate()
	print("instantiate")
	add_child(instance)
	print("add child")
	
func battle():
	reset()
	var instance = battle_scene.instantiate()
	add_child(instance)
	
func start():
	full_reset()
	var instance = start_scene.instantiate()
	add_child(instance)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#start()
	shop()
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func reset():
	for child in get_children():
		if child.name != "AudioStreamPlayer":
			child.queue_free()

func full_reset():
	reset()
	for i in stats.keys():
		stats[i] = 10

func change_stat(stat, change):
	stats[stat] += change

func get_stats():
	return stats

func game_over():
	for child in get_children():
		child.queue_free()

func generate_rarity():
	var number = randi() % 100
	if number < 50:
		return 0
	elif number < 80:
		return 1
	elif number < 95:
		return 2
	else:
		return 3
	
func generate_card():
	return randi() % len(data[0])

func load_data():
	var file = FileAccess.open("res://data/cards.json", FileAccess.READ)
	var content = file.get_as_text()
	return JSON.parse_string(content)
