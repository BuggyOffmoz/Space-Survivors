extends Node2D

class_name BaseShip

@export var d = {}

var first_movement_fix := true
#var level : global_level
@export var MovementComponent : BaseShipMovement
@onready var actual_movement = $Movements/BaseShipMovement
@export var special_movement : Node2D

var fact = 0.007

var last_direction : Vector2
var assigned_device : String = "null"

var is_on_special_movement := false

var final_rotation : float
var fix_ship_rotation : float
@export var turret : Turret 

var move_x : float
var move_y : float

func _ready():
	await get_tree().create_timer(0.2).timeout
	first_movement_fix = false

func _input(event):
	if not first_movement_fix:
		if (event is InputEventJoypadMotion 
		and str(event.device) == assigned_device
		and not is_on_special_movement
		and not special_movement.special_cooldow
		):
			if event.axis == 5 and event.is_pressed():
				is_on_special_movement = true
				actual_movement = special_movement
		
		elif (event is InputEventKey
		and assigned_device == "Keyboard"
		and not is_on_special_movement
		and not special_movement.special_cooldow
		):
			if event.is_action_pressed("Special"):
				is_on_special_movement = true
				actual_movement = special_movement
		
		actual_movement._input_event(event)


func _physics_process(delta):
	actual_movement._physics_process_(delta)



