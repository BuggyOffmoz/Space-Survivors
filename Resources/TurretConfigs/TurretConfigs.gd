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
	"cadence" : 0.0,
	"spread" : 0.0,
	"piercing" : 0.0,
	"multi_shot" : 0.0,
	"bounce_duplication" : 0.0,
	"mark_count" : 0.0,
	"insta_explotion" : 0.0
}
## TODO


# Esta funcion podria servir tanto a la hora de inicializar la torreta, como a la hora de cambiarla en tiempo real
func auto_config(_turret_type:int,_turret:Turret):
	
	turret = _turret
	
	match _turret_type:
		Turret.all_turret_type.GATLING:
			gatling_config()
		Turret.all_turret_type.VOID_LASER:
			void_laser_config()
		Turret.all_turret_type.COHETE:
			pass
		_:
			push_error("This Turret ´ID´ was not found: ",_turret_type)
		
	

func upgrade_stat(_value,_stat:="null"):
	if bullet_info.has(_stat):
		bullet_info._stat += _value
	else:
		push_error("This stat does not exist: "+_stat)

func downgrade_stat(_value,_stat:="null"):
	if bullet_info.has(_stat):
		bullet_info._stat -= _value
	else:
		push_error("This stat does not exist: "+_stat)

func get_turret_value(_stat:="null"):
	if bullet_info.has(_stat):
		return(bullet_info[_stat])
	else:
		return(-404)
		push_error("This stat does not exist: "+_stat)
	

func gatling_config():
	turret.cadence = 0.07
	
	bullet_info.damage = 30.0
	bullet_info.speed = 25.0
	bullet_info.top_distance = 700.0
	bullet_info.size = 6.2
	bullet_info.bounce_amount = 0
	
	turret.forward_distance_cannon = 60
	

func void_laser_config():
	turret.cadence = 0.1
	
	bullet_info.bounce_amount = 10
	bullet_info.damage = 30.0
	bullet_info.size = 20.0
	bullet_info.attack_count = 1
	bullet_info.cadence = 1.0
	
	turret.forward_distance_cannon = 60

