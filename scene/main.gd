extends Node2D

var Enemy_scene = load("res://scene/enemy.tscn")
var Player_scene = load("res://scene/character.tscn")
var nogod = 0
var player_n = "Player" + str(nogod)
var enemy_n = "Enemy"

@onready var Enemy_node = get_node(enemy_n)
@onready var Player_node = get_node(player_n)

# Called every frame. 'delta' is the elapsed time since the previous frame.
var over = true
func _process(delta: float) -> void:
	if not (get_node_or_null("Enemy")) and over:
		over = false
		await get_tree().create_timer(1.0).timeout
		over = true
		_sin()
		
func _sin():
		
		nogod += 1
<<<<<<< HEAD
		player_n = "Player" + str(nogod)
		Player_node = get_node(player_n)
		print(nogod)
		print(Player_node)
		(Player_node).queue_free()
		
		print("british slang for ciggerate")
		
=======
		print(player_n)
		#(Player_node).queue_free()
>>>>>>> a36a4f0f26fb399dd954705d48bff792464d19c5
		
		
		var enemey = Enemy_scene.instantiate()
		add_child(enemey)
		enemey.name = enemy_n
		enemey.global_position = $E_start.global_position
		
		var player = Player_scene.instantiate()
		add_child(player)
		player.name = player_n
		print(player)
		player.global_position = $P_start.global_position
