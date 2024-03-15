extends Node2D


@onready var ship : BaseShip = get_parent().owner
@onready var MovementComponent := ship.normal_movement
@onready var graphics : Node2D = ship.get_node("Graphics")

var fact = 0.007

var last_direction : Vector2

var is_drifting := false
var special_cooldow := false
var is_verify_drifting := false

var final_rotation : float
var fix_ship_rotation : float

var move_x : float
var move_y : float


func _input_event(event):
	
	if event is InputEventKey and ship.assigned_device == "Keyboard":
		move_x = Input.get_axis("K_Left","K_Right")
		move_y = Input.get_axis("K_Up","K_Down")
		
		if event.is_action_pressed("Special") and not is_drifting and not special_cooldow:
			is_verify_drifting = true
			last_direction = MovementComponent.last_direction
			verify_drift_direction()
		if event.is_action_released("Special") and not is_drifting and is_verify_drifting:
			is_verify_drifting = false
		elif event.is_action_released("Special") and is_drifting:
			is_verify_drifting = false
			release_drift()
		
	if event is InputEventJoypadMotion and str(event.device) == ship.assigned_device:
		
		if event.axis == 0:
			move_x = event.axis_value
		if event.axis == 1:
			move_y = event.axis_value
		
		if event.axis == 5 and event.is_pressed() and not is_drifting and not special_cooldow:
			is_verify_drifting = true
			last_direction = MovementComponent.last_direction
			verify_drift_direction()
		if event.axis == 5 and event.is_released() and not is_drifting and is_verify_drifting:
			is_verify_drifting = false
		elif event.axis == 5 and event.is_released() and is_drifting:
			is_verify_drifting = false
			release_drift()

		
	

func _physics_process_(delta):
	if is_verify_drifting:
		ship.global_position += last_direction * 6
	elif is_drifting:
		drifting_movement(delta)
	if ship.turret != null:
		ship.turret.global_position = global_position

func drifting_movement(delta):
	ship.global_position += Vector2.UP.rotated(graphics.rotation).normalized() * 12
	graphics.rotation = lerp_angle(graphics.rotation, final_rotation,fact)
	if fact < 0.5:
		fact += 0.001

func verify_drift_direction():
	var right = last_direction.rotated(deg_to_rad(+90))
	var left = last_direction.rotated(deg_to_rad(-90))
	
	
	
	await get_tree().create_timer(0.15).timeout
	
	
	
	if Vector2(move_x,move_y).dot(left) > 0.5:
		is_drifting = true
		is_verify_drifting = false
		final_rotation = graphics.rotation + deg_to_rad(180)
		graphics.get_node("ShipSprite").rotation_degrees -= 45
		graphics.get_node("DriftParticles").emitting = true
		%DriftCooldown.start()
	elif Vector2(move_x,move_y).dot(right) > 0.5:
		is_drifting = true
		is_verify_drifting = false
		final_rotation = graphics.rotation - deg_to_rad(180)
		graphics.get_node("ShipSprite").rotation_degrees += 45
		graphics.get_node("DriftParticles").emitting = true
		%DriftCooldown.start()
	else:
		is_verify_drifting = false
		release_drift()
	

func release_drift():
	ship.MovementComponent.restore(Vector2(move_x,move_y))
	ship.change_movement_state(BaseShip.ship_states.NORMAL)
	
	is_drifting = false
	special_cooldow = true
	ship.is_on_special_movement = false
	graphics.get_node("DriftParticles").emitting = false
	graphics.get_node("ShipSprite").rotation_degrees = 0
	
	fact = 0.007
	
	await get_tree().create_timer(2.0).timeout
	special_cooldow = false


func _on_drift_cooldown_timeout():
	release_drift()
