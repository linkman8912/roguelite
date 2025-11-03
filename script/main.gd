extends Node2D
var Enemy_scene = load("res://scene/oldenemy.tscn")
var Player_scene = load("res://scene/oldcharacter.tscn")
var player_n = "Player"
var enemy_n = "Enemy"
@onready var Enemy_node = get_node(enemy_n)
@onready var Player_node = get_node(player_n)
var stat_manager = null
var stats = {}

func _ready() -> void:
	#reset()
	Console.add_command("reset",reset,0)
	Console.add_command("who_is_in_paris",paris,0)



func paris():
	Console.print_line("Niggas")
func reset():
	$Control.visible = false
	$game.visible = true
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
	
	
	Player_node.name = player_n
	Player_node.global_position = $game/P_start.global_position
func set_stats(new_stats: Dictionary):
	stats = new_stats
func apply_stats():
	if stat_manager:
		stat_manager.set_stats(stats)
