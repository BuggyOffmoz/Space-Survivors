extends Node2D

class_name BulletManager

var bullets_aviable : Array

@export var all_bullet_path : Array[PackedScene]

func _ready() -> void:
	pass


func _process(delta):
	$"../CanvasLayer/Label".text = str(bullets_aviable.size())

func create_bullets(turret_type:=0):
	var node_content = create_bullets_node_contetn(turret_type)
	for index in 500:
		var new_bullet = all_bullet_path[turret_type].instantiate()
		bullets_aviable.append(new_bullet)
		new_bullet.name = "Bullet"
		node_content.add_child(new_bullet,true)

func create_bullets_node_contetn(name_index:=0):
	var new_bullet_content : Node2D = Node2D.new()
	new_bullet_content.name = Turret.all_turret_type.keys()[name_index].to_lower()
	add_child(new_bullet_content,true)
	return(new_bullet_content)

func get_bullet():
	
	if not bullets_aviable.is_empty():
		var bullet = bullets_aviable.front()
		bullets_aviable.erase(bullet)

		return(bullet)
	else:
		var new_bullet = preload("res://Scenes/Components/BaseBullet/LaserBullet/LaserBullet.tscn").instantiate()
		bullets_aviable.append(new_bullet)
		new_bullet.name = "Bullet"
		add_child(new_bullet,true)
		return(new_bullet)
	

func store_bullet(_bullet):
	if not bullets_aviable.has(_bullet):
		bullets_aviable.append(_bullet)


func clean_bullets_in_windows():
	pass

func explode_all_bullets():
	pass

