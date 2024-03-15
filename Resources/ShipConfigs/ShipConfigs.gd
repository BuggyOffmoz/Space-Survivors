extends Resource

class_name ShipConfig

var base_ship : BaseShip

@export_category("Movements Scenes Paths")
@export var drift_movement : PackedScene = preload("res://Scenes/Components/SpecialShipMovement/DriftMovement.tscn")

enum all_ships_type {
	SAW_SHIP,
	VOID_SHIP
}


var bullet_info = {
	"attack_count" : 0,
	"bounce_amount" : 0,
	
	"invulnerability" : 0.0,
	"damage" : 0.0,
	"speed" : 0.0,
	"size" : 0.0,
	"speed_damp" : 0.0,
}

func auto_config(_ship_type:all_ships_type,_base_ship:BaseShip):
	base_ship = _base_ship
	
	match _ship_type:
		all_ships_type.SAW_SHIP:
			saw_configurations()
		all_ships_type.VOID_SHIP:
			void_configuratios()
		
	

func saw_configurations():
	
	base_ship.assign_movements(drift_movement,true)

func void_configuratios():
	pass
