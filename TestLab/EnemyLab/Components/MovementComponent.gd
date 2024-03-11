extends Node2D

@onready var targetVector = $targetVector.position
@export_range(0, 10, 0.1) var speed
var screensize

# Called when the node enters the scene tree for the first time.
func _ready():
	targetVector = targetVector.normalized()
	screensize = get_viewport().get_visible_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_parent().position += targetVector * speed
	
	print(screensize)
	print(get_parent().position)
	
	if get_parent().position.x < 0:
		get_parent().position.x = screensize.x
	if get_parent().position.y < 0:
		get_parent().position.y = screensize.y
	if get_parent().position.x > screensize.x:
		get_parent().position.x = 0
	if get_parent().position.y > screensize.y:
		get_parent().position.y = 0
	
