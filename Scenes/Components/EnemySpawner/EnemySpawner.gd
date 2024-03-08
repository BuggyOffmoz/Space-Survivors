extends Node2D

class_name EnemySpawner

@onready var ship = %Players.get_node("BaseShip")

var active := false

var spawn_cooldown := 0.2
 
var spawner_radio := 800

var enemy_a := preload("res://Scenes/Enemies/TestEnemy.tscn")

var enemy_list_a : Array[BaseEnemy]

func _ready():
	auto_config()
	spawn_enemy()

func auto_config():
	for x in 500:
		var new_enemy : BaseEnemy = enemy_a.instantiate()
		new_enemy.ship = ship
		new_enemy.EnemyManager = self
		
		enemy_list_a.append(new_enemy)
		
		add_child(new_enemy)


func spawn_enemy():
	if active:
		var enemy_picked : BaseEnemy = enemy_list_a.front()
		enemy_list_a.erase(enemy_picked)
		var random_spawn_direction = randf_range(0,360)
		
		enemy_picked.global_position = ship.global_position + Vector2(1,0).rotated(deg_to_rad(random_spawn_direction)).normalized() * spawner_radio
		
		enemy_picked.activate_enemy()
		
		await get_tree().create_timer(spawn_cooldown).timeout
		
		spawn_enemy()

func store_enemy(_enemy:BaseEnemy):
	if not enemy_list_a.has(_enemy):
		enemy_list_a.append(_enemy)
