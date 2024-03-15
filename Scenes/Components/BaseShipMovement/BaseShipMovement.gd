extends Node2D

class_name BaseShipMovement

@export var ship : BaseShip
@export var graphics : Node2D

var last_direction : Vector2

var move_x : float
var move_y : float

func _input_event(event):
	
	if event is InputEventKey and ship.assigned_device == "Keyboard":
		move_x = Input.get_axis("K_Left","K_Right")
		move_y = Input.get_axis("K_Up","K_Down")
		last_direction = Vector2(move_x,move_y)
	
	
	if event is InputEventJoypadMotion and str(event.device) == ship.assigned_device:
		if event.axis == 0:
			move_x = event.axis_value
		if event.axis == 1:
			move_y = event.axis_value
		last_direction = Vector2(move_x,move_y)
	



func _physics_process_(delta):
	if move_x != 0 or move_y != 0:
		normal_movement()
	if ship.turret != null:
		ship.turret.global_position = global_position



func normal_movement(_chase:=false):
	if move_x != 0 or move_y != 0:
		ship.global_position += Vector2(move_x,move_y).normalized() * 9
		graphics.rotation = Vector2(move_x,move_y).angle() - deg_to_rad(270)

func restore(_last_direction:Vector2) -> void:
	move_x = _last_direction.x
	move_y = _last_direction.y
