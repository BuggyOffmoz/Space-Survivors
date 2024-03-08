extends Area2D

class_name BaseBullet

@onready var Bullet_Manager : BulletManager = get_parent()
 

var aviable := true
var in_use := false

var bullet_stats = {
	"direction" : Vector2(0,0),
	"initial_position" : Vector2(0,0),
	"bounce_amount" : 0,
	"damage" : 0.0,
	"top_distance" : 0.0,
	"speed" : 0.0,
	"size" : 0.0,
	"speed_damp" : 0.0
}

func _physics_process(delta) -> void:
	if in_use:
		normal_movement()
	

func normal_movement():
	
	global_position += bullet_stats.direction.normalized() * bullet_stats.speed
	verify_distance()

func use_bullet() -> void:
	
	in_use = true
	visible = in_use
	%Collision.set_deferred("disabled",false)
	
	var ang = randf_range(deg_to_rad(10),deg_to_rad(-10))
	var spd = randf_range(bullet_stats.speed/8,-bullet_stats.speed/8)
	
	bullet_stats.direction = bullet_stats.direction.rotated(ang)
	bullet_stats.speed += spd
	
	global_position = bullet_stats.initial_position
	%Graphics.scale = Vector2(1,1) + Vector2(bullet_stats.size,bullet_stats.size)
	
	%Graphics.rotation = bullet_stats.direction.angle()

func disable_bullet() -> void:
	in_use = false

	visible = in_use
	%Collision.set_deferred("disabled",true)
	
	#bullet_stats.direction = Vector2.ZERO
	#bullet_stats.initial_position = Vector2.ZERO
	#
	#bullet_stats.bounce_amount = 0
	#bullet_stats.top_distance = 0.0
	#bullet_stats.speed = 0.0
	#bullet_stats.speed_damp = 0.0
	
	Bullet_Manager.store_bullet(self)
	

func verify_distance():
	if bullet_stats.initial_position.distance_to(global_position) >= bullet_stats.top_distance:
		disable_bullet()

func _on_area_entered(area):
	
	if area is BaseEnemy:
		var enemy : BaseEnemy = area
		enemy.take_damage(bullet_stats.damage)
		
		disable_bullet()
	else:
		if bullet_stats.bounce_amount > 0:
			var p : Node2D = area.get_parent()
			if p.get_children().find(area) == 0 or p.get_children().find(area) == 1:
				bullet_stats.direction = bullet_stats.direction.bounce(Vector2(0,1))
			else:
				bullet_stats.direction = bullet_stats.direction.bounce(Vector2(1,0))

			%Graphics.rotation = bullet_stats.direction.angle()
			bullet_stats.bounce_amount -= 1
		else:
			disable_bullet()
		
