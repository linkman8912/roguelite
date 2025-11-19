extends Node2D
var Enemy_scene = load("res://scene/oldenemy.tscn")
var Player_scene = load("res://scene/oldcharacter.tscn")
var player_n = "Player"
var enemy_n = "Enemy"

@onready var Enemy_node = get_node(enemy_n)
@onready var Player_node = get_node(player_n)

func _ready() -> void:
	reset()
	spawn_arena()
	Console.add_command("reset",reset,0)

func spawn_arena():
	var randi = int(randf_range(1, 3))
	print(randi,"rand")
	var arena_scene = load("res://scene/arena"+str(randi) +".tscn")
	var arena = arena_scene.instantiate()
	add_child(arena)


func reset():
	if is_instance_valid(Player_node):
		(Player_node).queue_free()
	if is_instance_valid(Enemy_node):
		(Enemy_node).queue_free()
	await get_tree().create_timer(0.1).timeout
	spawn_player()
	spawn_enemy()

func spawn_enemy():
	Enemy_node = Enemy_scene.instantiate()
	add_child(Enemy_node)
	Enemy_node.name = enemy_n
	Enemy_node.global_position = $E_start.global_position

func spawn_player():
	Player_node = Player_scene.instantiate()
	add_child(Player_node)
	Player_node.name = player_n
	Player_node.global_position = $P_start.global_position
