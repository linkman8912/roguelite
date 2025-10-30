extends Area2D

var main
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	main = get_node_or_null("../..").get_node_or_null("Main")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# body_entered
	pass


func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
	#if body 
	#body._bounce(get_node("."))
	if main:
		pass
		
		
