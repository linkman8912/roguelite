extends Node2D

var rarities = ["common", "uncommon", "rare", "legendary"]

var borders = {
	"common": "res://assets/card_common.png",
	"uncommon": "res://assets/card_uncommon.png",
	"rare": "res://assets/card_rare.png",
	"legendary": "res://assets/card_legendary.png"
}
@onready var label: Label = $Label
# Called when the node enters the scene tree for the first time.

var card
var rarity

func _ready() -> void:
	var data = JSON.parse_string(load_from_file())
	rarity = genRarity()
	card = random(len(data[rarity]) - 1)
	
	while(isDupe()):
		card = random(len(data[rarity]) - 1)
	#print(card)
	text(data[rarity][card]["text"])
	#cardart(data[0][0])
	#print("rarity: " + str(rarity))
	#print("card: " + str(card))
	cardart(data[rarity][card]["art"])
	cardBorder(rarity)


func load_from_file():
	var file = FileAccess.open("res://data/cards.json", FileAccess.READ)
	var content = file.get_as_text()
	return content

func cardart(art):
	$CardArt.texture = load(art)
	#if you read this you are gay lmao
func random(upperBound):
	return randi() % upperBound

func genRarity():
	var number = randi() % 100
	if number < 50:
		return 0
	elif number < 80:
		return 1
	elif number < 95:
		return 2
	else:
		return 3

func cardBorder(rarity):
	$CardOutLine.texture = load(borders[rarities[rarity]])

func text(text): 
	print("text run")
	label.text = text
func isDupe():
	var card1dupe = (card == $"/root/Control/HBoxContainer/Container1/Control".card and not name == "Control")
	var card2dupe = (card == $"/root/Control/HBoxContainer/Container2/Control2".card and not name == "Control2") 
	var card3dupe = (card == $"/root/Control/HBoxContainer/Container3/Control3".card and not name == "Control3")
	return card1dupe or card2dupe or card3dupe 
