extends AudioStreamPlayer

var sound_path = "res://aduio/hit1.wav"
var current_sound_priority = 0  # 0 = normal, 1 = important (like parry)
var important_sounds = ["parry", "buycard"]  # List of sounds that shouldn't be interrupted

func play_sound(sound: String):
	
	# Check if this is an important sound
	var is_important = sound in important_sounds
	var new_priority = 1 if is_important else 0
	
	# Don't interrupt important sounds with normal sounds
	if playing and current_sound_priority > new_priority:
		return  # Don't play the new sound
	
	# Load and play the sound
	sound_path = load("res://aduio/" + str(sound) + ".wav")
	stream = sound_path
	current_sound_priority = new_priority
	play()

# Reset priority when sound finishes
func _ready():
	finished.connect(_on_finished)

func _on_finished():
	current_sound_priority = 0
