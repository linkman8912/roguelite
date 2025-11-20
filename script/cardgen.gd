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
var tween_intensity = 1.12
var tween_duration = 0.2

# Store original scales
var original_label_scale: Vector2

func _ready() -> void:
	rarity = main.generate_rarity()
	card = main.generate_card()
	while (isDupe()):
		card = main.generate_card()
	set_card(rarity, card)
	sound_node = $"/root/Main/audio_node"
	
	# Store the original label scale
	original_label_scale = $Label.scale
	
	$Button.mouse_entered.connect(_on_button_mouse_entered)
	$Button.mouse_exited.connect(_on_button_mouse_exited)

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
	await get_tree().create_timer(1.5).timeout
	main.battle()

func _on_button_mouse_entered() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	sound_node.pitch_scale = rng.randf_range(0.8, 1.1)
	sound_node.play_sound("hovercard")
	sound_node.pitch_scale = 1.0
	
	start_tween($Button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	start_tween($CardArt, "scale", Vector2.ONE * tween_intensity, tween_duration)
	start_tween($CardOutLine, "scale", Vector2.ONE * tween_intensity, tween_duration)
	start_tween($Label, "scale", original_label_scale * tween_intensity, tween_duration)

func _on_button_mouse_exited() -> void:
	start_tween($Button, "scale", Vector2.ONE, tween_duration)
	start_tween($CardArt, "scale", Vector2.ONE, tween_duration)
	start_tween($CardOutLine, "scale", Vector2.ONE, tween_duration)
	start_tween($Label, "scale", original_label_scale, tween_duration)
	
func start_tween(object: Object, property: String, final_value: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_value, duration)
