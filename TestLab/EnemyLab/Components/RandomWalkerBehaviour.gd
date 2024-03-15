extends Node

@export var movementComponent: Node
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	var newMovementVector = Vector2(rng.randf_range(-1, 1), rng.randf_range(-1, 1))

	movementComponent.setTarget(newMovementVector)
