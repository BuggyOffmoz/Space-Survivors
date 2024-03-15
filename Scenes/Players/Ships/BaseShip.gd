extends Node2D

class_name BaseShip

var ship_configs := ShipConfig.new()

enum ship_states {
	NORMAL,
	SPECIAL
}
@export var state : ship_states

@export var ship_type : ShipConfig.all_ships_type

var first_movement_fix := true
#var level : global_level
@export var MovementComponent : BaseShipMovement
@onready var actual_movement = $Movements/BaseShipMovement
var special_movement : Node2D
@export var normal_movement : Node2D


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
	auto_config()
	await get_tree().create_timer(0.2).timeout
	first_movement_fix = false

func _input(event):
	verify_special_if_special_input(event)
	
	actual_movement._input_event(event)

func auto_config():
	ship_configs.auto_config(ship_type,self)

func change_movement_state(state:ship_states):
	match state:
		ship_states.NORMAL:
			actual_movement = normal_movement
		ship_states.SPECIAL:
			actual_movement = special_movement


func assign_movements(_movement_path:PackedScene,_is_special:=false):
	var new_movement = _movement_path.instantiate()
	%Movements.add_child(new_movement)
	
	if _is_special:
		special_movement = new_movement
	

func verify_special_if_special_input(_event:InputEvent):
	if not first_movement_fix:
		if (_event is InputEventJoypadMotion 
		and str(_event.device) == assigned_device
		and not is_on_special_movement
		and not special_movement.special_cooldow
		):
			if _event.axis == 5 and _event.is_pressed():
				is_on_special_movement = true
				actual_movement = special_movement
		
		elif (_event is InputEventKey
		and assigned_device == "Keyboard"
		and not is_on_special_movement
		and not special_movement.special_cooldow
		):
			if _event.is_action_pressed("Special"):
				is_on_special_movement = true
				actual_movement = special_movement

func _physics_process(delta):
	actual_movement._physics_process_(delta)
