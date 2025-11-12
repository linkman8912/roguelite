extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var data = JSON.parse_string(load_from_file())
	cardart(data[0][0]["art"])
	
func load_from_file():
	var file = FileAccess.open("res://data/formattedCards.json", FileAccess.READ)
	var content = file.get_as_text()
	return content
func cardart(art):
	var texture = load(art)
