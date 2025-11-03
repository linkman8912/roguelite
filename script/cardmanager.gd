extends Node

const cards = [["speed", "increases player speed by 50%"], ["damage", "increases damage by 50%"]]
var card

func _ready():
	card = 0
	pass




func _process(delta: float) -> void:
	pass
	print(cards[card][0])
	print(cards[card][1])
	
	
