extends Control

var path= "res://data/cards.json"
var json
var cards

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	var json_text = load_from_file("res://data/cards.json")
	#var json = JSON.new()
	json = JSON.parse_string(json_text)
	#print(json)
	#for i in (json[1]["stats"]):
	#	print(JSON.parse_string(i))
	print(JSON.parse_string(json[0][0]["stats"])["speed"])
	json[0][0]
	var file = FileAccess.open( path, FileAccess.READ)
	
func load_from_file(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	return content
