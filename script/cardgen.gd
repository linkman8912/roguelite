extends Control

var borders = {
	"common": "res://assets/card_common.png",
	"uncommon": "res://assets/card_uncommon.png",
	"rare": "res://assets/card_rare.png",
	"legendary": "res://assets/card_legendary.png"
}
@onready var label: Label = $Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var data = JSON.parse_string(load_from_file())
	var rarity = rarity()
	var card = random(len(data[rarity]) - 1)
	print(card)
	text(data[0][0]["text"])
	#cardart(data[0][0])
	#cardart(data[rarity][card]["art"])
	cardBorder(borders[data[rarity][card]["rarity"]])	
	

func load_from_file():
	var file = FileAccess.open("res://data/formattedCards.json", FileAccess.READ)
	var content = file.get_as_text()
	return content

func cardart(art):
	$CardArt.texture = load(art)
	#if you read this you are gay lmao
func random(upperBound):
	return randi() % upperBound

func rarity():
	var number = randi() % 100
	if number < 50:
		return 0
	elif number < 80:
		return 1
	elif number < 95:
		return 2
	else:
		return 3

func cardBorder(border):
	pass

func text(text): 
	print("text run")
	label.text = text
