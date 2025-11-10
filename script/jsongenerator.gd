extends Node

var stats = [
  "health",
  "damage",
  "playerSpeed",
  "playerControl",
  "weaponSpeed",
  "weaponLength",
  "luck",
]

var oppositeStats = [
  "damage",
  "health",
  "playerControl",
  "playerSpeed",
  "weaponLength",
  "weaponSpeed",
  "luck",
]

var rarities = [
  "common",
  "uncommon",
  "rare",
  "legendary"
]

var rarityMultipliers = [
  1,
  2,
  3,
  5
]

var jsonList = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var currentid = 0;
	for i in range(len(rarities)): # set up structure
		jsonList.append([])
	for i in range(len(rarities)): # programatically add all cards
		for j in range(len(stats)):
			jsonList[i].append({
				"id": currentid,
				"name": "increase of " + stats[j],
				"text": "Increases " + stats[j] + " by " + str(1 * rarityMultipliers[i]),
				"rarity": rarities[i],
				"stats": "{\"" + stats[j] + "\": " + str(1 * rarityMultipliers[i]) + "}"
			})
			currentid += 1
			if stats[j] != "luck":
				jsonList[i].append({
					"id": currentid,
					"name": "cost of " + stats[j],
					"text": "Increases " + stats[j] + " by " + str(2 * rarityMultipliers[i]) + ", decreases " + oppositeStats[j] + " by " + str(1 * rarityMultipliers[i]),
					"rarity": rarities[i],
					"stats": "{\\\"" + stats[j] + "\\\": " + str(2 * rarityMultipliers[i]) + ", \\\"" + oppositeStats[j] + "\\\": " + str(-1 * rarityMultipliers[i]) + "}"
		  		})
				currentid += 1
	var jsonString = JSON.stringify(jsonList)
	save_to_file(jsonString, "res://data/cards.json")
	#var json = JSON.new()
	#var error = json.parse(jsonString)
	
	#if error == OK:
		#print("ok")
	#else:
		#print("fail")
		#print("parse error: " + error)
	#print(jsonList)



	# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func save_to_file(content, dir):
	var file = FileAccess.open(dir, FileAccess.WRITE)
	file.store_string(content)
