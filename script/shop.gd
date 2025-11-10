extends Control

var card = preload("res://card.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var card1 = card.instantiate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
