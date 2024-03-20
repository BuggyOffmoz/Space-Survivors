@tool
extends Node

const MAX_RANDOM_DELAY = 30
const MAX_RANDOM_SPEED = 50

@export var movementComponent: Node

@export var randomDelay:= false:
	set(value):
		randomDelay = value
		notify_property_list_changed()

@export_range(0, 10) var delaySeconds: float

@export_range(0, MAX_RANDOM_DELAY) var minRandomDelay: float
@export_range(0, MAX_RANDOM_DELAY) var maxRandomDelay: float

@export var randomSpeed:= false:
	set(value):
		randomSpeed = value
		notify_property_list_changed()

@export_range(0, 30) var fixedSpeed: float

@export_range(0, MAX_RANDOM_SPEED) var minRandomSpeed: float
@export_range(0, MAX_RANDOM_SPEED) var maxRandomSpeed: float

var currentDelay
var currentSpeed
var secondsSinceDelay = 0.0


var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	print(movementComponent)


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	pass

func _physics_process(delta):
	if not Engine.is_editor_hint():
		if randomDelay:
			currentDelay = rng.randf_range(minRandomDelay, maxRandomDelay)
			
		else:
			currentDelay = delaySeconds
			
		if randomSpeed:
			currentSpeed = rng.randf_range(minRandomSpeed, maxRandomSpeed)
		else:
			currentSpeed = fixedSpeed
		
		secondsSinceDelay += delta
		
		if secondsSinceDelay >= currentDelay:
			var newMovementVector = Vector2(rng.randf_range(-1, 1), rng.randf_range(-1, 1))
			
			movementComponent.setTarget(newMovementVector)
			movementComponent.setSpeed(currentSpeed)
			
			secondsSinceDelay = 0.0

func _validate_property(property: Dictionary):
	if property.name == "delaySeconds" and randomDelay:
		property.usage = PROPERTY_USAGE_NO_EDITOR
	
	if property.name == "fixedSpeed" and randomSpeed:
		property.usage = PROPERTY_USAGE_NO_EDITOR
	
	if property.name == "minRandomDelay":
		if  not randomDelay:
			property.usage = PROPERTY_USAGE_NO_EDITOR
	
	if property.name == "maxRandomDelay":
		if  not randomDelay:
			property.usage = PROPERTY_USAGE_NO_EDITOR
	
	if property.name == "minRandomSpeed":
		if  not randomSpeed:
			property.usage = PROPERTY_USAGE_NO_EDITOR
	
	if property.name == "maxRandomSpeed":
		if  not randomSpeed:
			property.usage = PROPERTY_USAGE_NO_EDITOR
