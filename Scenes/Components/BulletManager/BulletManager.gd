extends Node2D

class_name BulletManager

var bullets_aviable : Array

func _ready() -> void:
	for index in 2000:
		var new_bullet = preload("res://Scenes/Components/BaseBullet/BaseBullet.tscn").instantiate()
		bullets_aviable.append(new_bullet)
		new_bullet.name = "Bullet"
		add_child(new_bullet,true)
	

func _process(delta):
	$"../CanvasLayer/Label".text = str(bullets_aviable.size())
	
func get_bullet():
	
	if not bullets_aviable.is_empty():
		var bullet = bullets_aviable.front()
		bullets_aviable.erase(bullet)

		return(bullet)
	else:
		var new_bullet = preload("res://Scenes/Components/BaseBullet/BaseBullet.tscn").instantiate()
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

