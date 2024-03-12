extends Area2D

class_name BaseEnemy

var life := 200.0

@onready var base_movement : BaseEnemyMovement = get_node("Movement/BaseEnemyMovement")
var EnemyManager : EnemySpawner

var ship : BaseShip

var active := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func activate_enemy():
	active = true
	visible = active
	$CollisionShape2D.set_deferred("disabled",false)
	base_movement.on_movement = true


func disable_enemy():
	active = false
	visible = active
	life = 200
	$CollisionShape2D.set_deferred("disabled",true)
	base_movement.on_movement = false
	EnemyManager.store_enemy(self)

func take_damage(_damage:float):
	
	if (life - _damage) <= 0:
		disable_enemy()
	else:
		life -= _damage
