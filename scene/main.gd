extends Node2D

var Enemy_node = load("res://fixedenemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not get_node_or_null("Enemy"):
		var enemey = Enemy_node.instantiate()
		add_child(enemey)
