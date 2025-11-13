extends Node2D

var rarities = [
	"common",
	"uncommon",
	"rare",
	"legendary"
]

@onready var main = $"/root/Main"
var rarity
var card

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rarity = main.generate_rarity()
	card = main.generate_card()
	#while (isDupe()):
	#	card = main.generate_card
	set_card(rarity, card)


func cardart(art):
	$CardArt.texture = load(art)

func label(text):
	$Label.text = text

func border(rarity):
	$CardOutLine.texture = load("res://assets/card_" + rarities[rarity] + ".png")

func set_card(rarity, card):
	cardart(main.data[rarity][card]["art"])
	label(main.data[rarity][card]["text"])
	border(rarity)

func isDupe():
	var card1 = $"../../Container1/Control"
	var card2 = $"../../Container2/Control2"
	var card3 = $"../../Container3/Control3"
	var dupe1 = (rarity == card1.rarity && !(name == "Control"))
	var dupe2 = (rarity == card2.rarity && !(name == "Control2"))
	var dupe3 = (rarity == card3.rarity && !(name == "Control3"))
	return dupe1 || dupe2 || dupe3

func _on_button_pressed() -> void:
	var deez = main.battle()
