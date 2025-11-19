extends Node

#stats
var stats = {
	"health": 10,
	"damage": 10,
	"playerSpeed": 10,
	"playerControl": 10,
	"weaponSpeed": 10,
	"weaponLength": 20,
	"luck": 10
}

var stat_manager

@onready var shop_scene = load("res://scene/shop.tscn")
@onready var battle_scene = load("res://scene/battle.tscn")
@onready var start_scene = load("res://scene/start.tscn")
@onready var loading_scene = load("res://scene/loading.tscn")

var data = load_data()

var battles_won = 0

var playing = false

func shop():
	reset()
	var instance = shop_scene.instantiate()
	add_child(instance)
	battles_won += 1

func battle():
	reset()
	var instance = battle_scene.instantiate()
	add_child(instance)
	loading()
	playing = false

func loading():
	var instance = loading_scene.instantiate()
	add_child(instance)

func start_battle():
	$"loading".queue_free()
	playing = true


func start():
	full_reset()
	var instance = start_scene.instantiate()
	add_child(instance)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#start()
	shop()
	battles_won = 0



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	apply_stats()

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
	if number < 50 / (stats["luck"] / 10):
		return 0
	elif number < 80 / (stats["luck"] / 10):
		return 1
	elif number < 95 / (stats["luck"] / 10):
		return 2
	else:
		return 3
	
func generate_card():
	return randi() % len(data[0])

func load_data():
	var file = FileAccess.open("res://data/cards.json", FileAccess.READ)
	var content = file.get_as_text()
	return JSON.parse_string(content)

func apply_card(rarity, card):
	var stat_changes = JSON.parse_string(data[rarity][card]["stats"])
	for stat in stat_changes:
		change_stat(stat, stat_changes[stat])
	apply_stats()
func apply_stats():
	if not stat_manager:
		#if get_node_or_null("game") && get_node_or_null("game/Player") && get_node_or_null("game/player/stat_manager"):
			##stat_manager = get_node_or_null("game").get_node_or_null("Player").get_node_or_null("stat_manager")
			#stat_manager = get_node("game").get_node("Player").get_node("stat_manager")
		stat_manager = get_node_or_null("game/Player/stat_manager")
	if stat_manager && stat_manager.get_front_stats() != stats:
		stat_manager.set_front_stats(stats)
		stat_manager.apply_stats()
