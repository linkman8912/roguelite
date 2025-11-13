extends Control

@onready var card = load("res://scene/cardv2.tscn")
#var card1_pos = $Marker2D.global_position
var card1
var card2
var card3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("tried to spawn cards")
	#var card1pos = $Marker2D.global_position
	#var instance = card.instantiate()
	#add_child(instance, true)
	#print(get_children(true))
	#$Control.global_position = card1pos
	
	
	
	#$Marker2D.add_child(instance)
	
	#var card1 = card.instantiate()
	#var instance1 = card.instantiate()
	#var instance2 = card.instantiate()
	#var instance3 = card.instantiate()
	#$HBoxContainer/Container1.add_child(instance1)
	#$HBoxContainer/Container2.add_child(instance2)
	#$HBoxContainer/Container3.add_child(instance3)
	#card1 = $HBoxContainer.spawnCard()
	#card2 = $HBoxContainer.spawnCard()
	#card3 = $HBoxContainer.spawnCard()
	#card.instantiate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func card_chosen(card):
	$"/root/Node2D".apply_card(card.rarity, card.card)
	queue_free()
