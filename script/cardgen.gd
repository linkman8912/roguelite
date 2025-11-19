extends Node2D

var rarities = [
	"common",
	"uncommon",
	"rare",
	"legendary"
]
var sound_node
@onready var main = $"/root/Main"
var rarity: int
var card: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rarity = main.generate_rarity()
	card = main.generate_card()
	while (isDupe()):
		card = main.generate_card()
	set_card(rarity, card)
	sound_node = $"/root/Main/audio_node"


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
	#var dupe1 = (rarity == card1.rarity && card == card1.card && !(name == "Control"))
	#var dupe2 = (rarity == card2.rarity && card == card2.card && !(name == "Control2"))
	#var dupe3 = (rarity == card3.rarity && card == card3.card && !(name == "Control3"))
	var dupe1 = (card == card1.card && !(name == "Control"))
	var dupe2 = (card == card2.card && !(name == "Control2"))
	var dupe3 = (card == card3.card && !(name == "Control3"))
	return dupe1 || dupe2 || dupe3
	
func randi_pitch():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	sound_node.pitch_scale = rng.randf_range(0.9, 1.0)
func _on_button_pressed() -> void:
	sound_node.play_sound("buycard")
	main.apply_card(rarity, card)
	await get_tree().create_timer(1.0).timeout
	main.battle()
	#var deez = main.battle()


func _on_button_mouse_entered() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	sound_node.pitch_scale = rng.randf_range(0.8, 1.1)
	sound_node.play_sound("hovercard")
