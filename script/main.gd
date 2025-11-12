extends Node2D
var Enemy_scene = load("res://scene/oldenemy.tscn")
var Player_scene = load("res://scene/oldcharacter.tscn")
var shop_scene = load("res://scene/shop.tscn")
var player_n = "Player"
var enemy_n = "Enemy"
@onready var Enemy_node = get_node(enemy_n)
@onready var Player_node = get_node(player_n)
var stat_manager = null
var stats = {}
var ui_cam_zoom = 1
var play_cam_zoom = 2.4
func _ready() -> void:
	
	Engine.max_fps = 60
	Console.add_command("reset",reset,0)
	Console.add_command("who_is_in_paris",paris,0)



func paris():
	Console.print_line("not a slur")
func reset():
	$Control.visible = false
	$game.visible = true
	$Camera2D.zoom = Vector2 (2.4,2.4) #zooms in on the area
	if is_instance_valid(Player_node):
		(Player_node).queue_free()
	if is_instance_valid(Enemy_node):
		(Enemy_node).queue_free()
	await get_tree().create_timer(0.1).timeout
	spawn_player()
	spawn_enemy()
	apply_stats()
	
func spawn_enemy():
	print("en")
	Enemy_node = Enemy_scene.instantiate()
	add_child(Enemy_node)
	Enemy_node.name = enemy_n
	Enemy_node.global_position = $game/E_start.global_position

func spawn_player():
	Player_node = Player_scene.instantiate()
	add_child(Player_node)
	stat_manager = Player_node.get_node("stat_manager")
	var sword_spawner = Player_node.get_node("sword_spawner")
	
	apply_stats()
	stat_manager.apply_stats()
	Player_node.name = player_n
	Player_node.global_position = $game/P_start.global_position
	sword_spawner.set_sword()
func set_stats(new_stats: Dictionary):
	stats = new_stats
	#print("set+stats",new_stats)

func get_stats():
	return stats

func apply_stats():
	if stat_manager:
		stat_manager.set_stats(stats)
func game_over():
	pass
func shop():
	var shop_instance = shop_scene.instantiate()
	add_child(shop_instance)
	
func apply_card(rarity, card):
	stat_manager.apply_card(rarity, card)
