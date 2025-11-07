extends Button

var bry =0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	bry+= 1
	if bry != 5:
		print("Bryson Pressed")
	if bry == 5:
		print("bryson Came... a lot")
	if bry == 10:
		print("please... stop milking bryson... please")
		
	if bry == 15:
		print("wait, why is it turning black")
	if bry == 100:
		print("oh my god im trans")
