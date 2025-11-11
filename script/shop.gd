extends Control

@onready var card = load("res://scene/cardv2.tscn")
var card1
var card2
var card3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("tried to spawn cards")
	#var card1 = card.instantiate()
	var instance1 = card.instantiate()
	var instance2 = card.instantiate()
	var instance3 = card.instantiate()
	$HBoxContainer/Container1.add_child(instance1)
	$HBoxContainer/Container2.add_child(instance2)
	$HBoxContainer/Container3.add_child(instance3)
	#card1 = $HBoxContainer.spawnCard()
	#card2 = $HBoxContainer.spawnCard()
	#card3 = $HBoxContainer.spawnCard()
	#card.instantiate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
