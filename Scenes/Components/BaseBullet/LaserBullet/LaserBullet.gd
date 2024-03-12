extends Area2D


class_name LazerBullet

@onready var Bullet_Manager : BulletManager = get_parent().get_parent()
@onready var wall_detector : RayCast2D = get_node("Detector/WallDetector")

var aviable := true
var in_use := false
var calculate_trajectory := false
var in_prosses := false

var segments_points : Array

var bullet_stats = {
	"direction" : Vector2(0,0),
	"initial_position" : Vector2(0,0),
	"bounce_amount" : 0,
	"damage" : 0.0,
	"cadence" : 0.0,
	"size" : 0.0,
	"attack_count" : 0
}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if in_use:
		normal_movement()
	

func normal_movement():
	if not calculate_trajectory and not in_prosses:
		calcule_trajectory()
	#else:
		#%WallDetector.rotation = bullet_stats.direction.angle()


func calcule_trajectory():
	var last_bounce : Vector2
	var points_positions : Array
	points_positions.append(global_position)
	
	if wall_detector.is_colliding() and not calculate_trajectory:
		
		in_prosses = true
		while bullet_stats.bounce_amount > 0:
			
			##ATRAPO el area con la que colisiona, y renuevo la trayectoria
			if wall_detector.is_colliding():
				
				var p : Node2D = wall_detector.get_collider().get_parent()
				
				if p.get_children().find(wall_detector.get_collider()) == 0 or p.get_children().find(wall_detector.get_collider()) == 1:
					bullet_stats.direction = bullet_stats.direction.bounce(Vector2(0,1))
				else:
					bullet_stats.direction = bullet_stats.direction.bounce(Vector2(1,0))
				
				last_bounce = wall_detector.get_collision_point()
				points_positions.append( wall_detector.get_collision_point())
				
				$Detector.global_position = wall_detector.get_collision_point()
				
				$Detector.rotation = bullet_stats.direction.angle()
				bullet_stats.bounce_amount -= 1
			else:
				pass
			
			await get_tree().create_timer(0.001).timeout
		
		desactivate_wall_detector()
		
		calculate_trajectory = true
		create_lazer(points_positions)
		await get_tree().create_timer(0.01).timeout
		auto_attack()
func desactivate_wall_detector():
	%WallDetector.set_deferred("enabled",false)
	%WallDetector.global_position = global_position

func create_lazer(points:Array):
	
	await get_tree().create_timer(0.001).timeout
	for point in points:
		%LazerLine.width = bullet_stats.size
		%LazerLine.add_point(%LazerLine.to_local(point))
	
	var line_poly
	
	for index in points.size():
		if index != points.size()-1:
			var two_points : Array = [points[index]]
			two_points.append(points[index+1])
			line_poly = Geometry2D.offset_polyline(two_points,%LazerLine.width/3)
		
			for po in line_poly:
				var new_poly : CollisionPolygon2D = CollisionPolygon2D.new()
				new_poly.polygon = po
				new_poly.position = to_local(points[0]*0.005)
				add_child(new_poly)

func auto_attack():
	for enemie in get_overlapping_areas():
		
		enemie.take_damage(bullet_stats.damage)
		
	
	
	await get_tree().create_timer(bullet_stats.cadence).timeout
	
	
	if bullet_stats.attack_count > 0:
		
		bullet_stats.attack_count -= 1
		
		auto_attack()
	else:
		disable_bullet()


func use_bullet() -> void:
	
	%WallDetector.set_deferred("enabled",true)
	
	global_position = bullet_stats.initial_position
	
	$Detector.rotation = bullet_stats.direction.angle()
	%Graphics.rotation = bullet_stats.direction.angle()
	in_use = true
	visible = in_use

func disable_bullet() -> void:
	in_use = false

	visible = in_use
	%WallDetector.set_deferred("enabled",false)
	
	for child in get_children():
		if child is CollisionPolygon2D:
			child.queue_free()
	
	%LazerLine.clear_points()
	
	bullet_stats.direction = Vector2.ZERO
	bullet_stats.initial_position = Vector2.ZERO
	
	bullet_stats.bounce_amount = 5
	bullet_stats.attack_count = 0
	bullet_stats.top_distance = 0.0
	bullet_stats.speed = 0.0
	bullet_stats.speed_damp = 0.0
	bullet_stats.cadence = 0.0
	
	Bullet_Manager.store_bullet(self)


