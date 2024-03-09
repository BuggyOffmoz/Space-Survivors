extends Node2D

class_name Turret

var t_test := AutoTurretConfig.new()

var turret_config := AutoTurretConfig.new()
@onready var bullet_manager : BulletManager = get_parent().owner.get_node("BulletManager")

@export_enum("gatlin","cohete","void_laser") var turret_type : String

var is_shothing := false
var aviable_cadence := true
var is_shothing_cooldown := false

var assigned_device : String = "null"

var cadence : float
var forward_distance_cannon : float

var move_x : float
var move_y : float



func _ready():
	turret_config.auto_config(turret_type,self)
	%CadenceCooldown.wait_time = cadence

func _input(event):
	
	if event is InputEventKey and assigned_device == "Keyboard":
		move_x = Input.get_axis("K_Left","K_Right")
		move_y = Input.get_axis("K_Up","K_Down")
		
		if event.is_action_pressed("shoot") and not is_shothing_cooldown and not is_shothing:
			is_shothing = true
		elif event.is_action_released("shoot"):
			is_shothing = false
		
	
	if event is InputEventJoypadMotion and str(event.device) == assigned_device:
		
		if event.axis == 0:
			move_x = event.axis_value
		if event.axis == 1:
			move_y = event.axis_value
		
		if event.axis == 5 and event.is_pressed() and not is_shothing_cooldown and not is_shothing:
			is_shothing = true
		elif event.axis == 5 and event.is_released():
			is_shothing = false


func _physics_process(delta):
	if move_x != 0 or move_y != 0:
		normal_rotation()
	if is_shothing and aviable_cadence:
		shoot()

func normal_rotation():
	$Graphcis.rotation = Vector2(move_x,move_y).angle() - deg_to_rad(270)

func shoot():
	
	aviable_cadence = false
	var t = true

	calculate_distance_and_init_position()
	
	if t:
		triple_shoothing(Vector2.UP.rotated(%Graphcis.rotation))
	else:
		var new_bullet = bullet_manager.get_bullet()
		
		new_bullet.bullet_stats = turret_config.bullet_info.duplicate()
		
		new_bullet.use_bullet()
	
	%CadenceCooldown.start()
	

func calculate_distance_and_init_position():
	turret_config.bullet_info.initial_position = %Graphcis.global_position + (Vector2.UP.rotated(%Graphcis.rotation) * forward_distance_cannon)
	turret_config.bullet_info.direction =  %Graphcis.global_position.direction_to(turret_config.bullet_info.initial_position)

## TEST
func triple_shoothing(_direction:Vector2):
	var forw = %Graphcis.global_position + _direction * forward_distance_cannon
	var fact_degrees = 20

	
	var chase := true
	var index_a := 0
	 
	for x in 40:
		var new_bullet = bullet_manager.get_bullet()
		
		new_bullet.bullet_stats = turret_config.bullet_info.duplicate()
		
		if chase:
			turret_config.bullet_info.direction = _direction.rotated(deg_to_rad(+fact_degrees))
			new_bullet.use_bullet()
		else:
			turret_config.bullet_info.direction = _direction.rotated(deg_to_rad(-fact_degrees))
			new_bullet.use_bullet()
		
		if index_a == 2:
			index_a = 0
			fact_degrees += 20
		index_a += 1 
		chase = !chase
		

func _on_cadence_cooldown_timeout():
	aviable_cadence = true
