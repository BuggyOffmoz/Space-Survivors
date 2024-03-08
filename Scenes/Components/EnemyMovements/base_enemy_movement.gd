extends Node2D

class_name BaseEnemyMovement

@onready var enemy_parent : BaseEnemy = get_parent().owner
@onready var graphics : Node2D = enemy_parent.get_node("Graphics")

var on_movement := false

var target : BaseShip

# Called when the node enters the scene tree for the first time.
func _ready():
	try_auto_config()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if on_movement and enemy_parent.active:
		move()

func try_auto_config():
	
	if not on_movement and target == null:
		if enemy_parent.ship != null:
			target = enemy_parent.ship
	
	if target == null:
		await get_tree().create_timer(0.1).timeout
		try_auto_config()

func move():
	enemy_parent.global_position += global_position.direction_to(target.global_position).normalized() * 3
	
	graphics.look_at(target.global_position)
