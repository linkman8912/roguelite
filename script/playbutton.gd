extends Button

var tween_intensity = 1.1
var tween_duration = 0.2
var sound_node


func randi_pitch():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	sound_node.pitch_scale = rng.randf_range(0.9, 1.0)
	
func _ready() -> void:
	pressed.connect(_on_button_pressed)
	# Connect the mouse hover signals
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	# Set pivot for scaling from center
	pivot_offset = size / 2
	sound_node = $"/root/Main/audio_node"

func _on_button_pressed():
	sound_node.play_sound("startgame")
	await get_tree().create_timer(2.0).timeout
	get_node("/root/Main").full_reset()
	get_node("/root/Main").shop()

func _on_mouse_entered():
	start_tween(self, "scale", Vector2.ONE * tween_intensity, tween_duration)
	sound_node.play_sound("hovercard")

func _on_mouse_exited():
	start_tween(self, "scale", Vector2.ONE, tween_duration)

func start_tween(object: Object, property: String, final_value: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_value, duration)
