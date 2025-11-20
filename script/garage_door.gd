extends Node2D

@onready var door_sprite = $"door_sprite"  # Adjust to your sprite's name
@onready var main = $"/root/Main"
@onready var audio_node = $"/root/Main/audio_node"

@export var height = 648

var slide_time: int = 1.707 # seconds
var sliding: bool = false

#func _process(delta: float):
  #pass


func close():
  slide(1)
  audio_node.play_sound("garageclose")

func open():
  slide(-1)
  audio_node.play_sound("garageopen")

func slide(direction):
  var tween = create_tween()

# Move sprite down 1152 pixels over 2 seconds with ease in/out
  tween.tween_property(door_sprite, "position:y", door_sprite.position.y + height * direction, slide_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

  tween.tween_callback(func(): slide_done(direction, self))

func slide_done(direction, garage_door):
  main.slide_done(direction, garage_door)
