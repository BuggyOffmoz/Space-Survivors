extends Node

var screensize

# Called when the node enters the scene tree for the first time.
func _ready():
	screensize = get_viewport().get_visible_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().position.x < 0:
		get_parent().position.x = screensize.x
	if get_parent().position.y < 0:
		get_parent().position.y = screensize.y
	if get_parent().position.x > screensize.x:
		get_parent().position.x = 0
	if get_parent().position.y > screensize.y:
		get_parent().position.y = 0
