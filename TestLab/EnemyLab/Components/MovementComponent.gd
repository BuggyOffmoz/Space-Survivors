extends Node2D

@onready var targetVector = $targetVector.position
@export_range(0, 10, 0.1) var speed


# Called when the node enters the scene tree for the first time.
func _ready():
	targetVector = targetVector.normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Being called in physics_process, delta is a constant and there is no need to adjust speed for it
	get_parent().position += targetVector.normalized() * speed

func setTarget(newPosition: Vector2):
	targetVector = newPosition
