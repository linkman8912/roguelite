extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$sword_spawner.spawn_sword(10,200,2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
