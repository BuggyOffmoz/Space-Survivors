extends Resource

class_name AutoTurretConfig

var turret : Turret

var bullet_info = {
	"attack_count" : 0,
	"bounce_amount" : 0,

	"direction" : Vector2(0,0),
	"initial_position" : Vector2(0,0),

	"damage" : 0.0,
	"speed" : 0.0,
	"top_distance" : 0.0,
	"size" : 0.0,
	"speed_damp" : 0.0,
	"cadence" : 0.0
}


func auto_config(_turret_type:String,_turret:Turret):
	turret = _turret
	if has_method(_turret_type+"_config"):
		call(_turret_type+"_config")


func gatlin_config():
	turret.cadence = 0.007
	bullet_info.damage = 30.0
	bullet_info.speed = 25.0
	bullet_info.top_distance = 700.0
	bullet_info.size = 6.2
	bullet_info
	turret.forward_distance_cannon = 60
	bullet_info.bounce_amount = 0

func void_laser_config():
	turret.cadence = 0.1
	bullet_info.bounce_amount = 1
	bullet_info.damage = 30.0
	bullet_info.size = 20.0
	bullet_info.attack_count = 1
	bullet_info.cadence = 1.0
	turret.forward_distance_cannon = 60

