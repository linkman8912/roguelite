extends AudioStreamPlayer

var sound_path = "res://aduio/hit1.wav"



func play_sound(sound):
	sound_path = load("res://aduio/"+str(sound)+".wav")
	stream = sound_path
	play()
