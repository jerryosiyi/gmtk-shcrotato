class_name CharacterBase
extends CharacterBody2D

signal state_change()

var stunned: bool

var health: float:
	get = _get_health

var max_health: float:
	get = _get_max_health

var speed: float:
	get = _get_speed

@onready var health_set: AttributeSet = get_node("Attributes/Health")
@onready var movement_set: AttributeSet = get_node("Attributes/Movement")

func _physics_process(delta):
	if velocity.length() > 0.0:
		play_animation("Run")
	else:
		play_animation("Idle")
	if velocity.x < 0:
		$Body.scale.x = -1
	elif velocity.x > 0:
		$Body.scale.x = 1

func play_animation(name: StringName):
	get_node("AnimationPlayer").play(name)

func take_damage(amount: float):
	if not health_set:
		return
	var effect: Effect = Effect.new("Health", Global.Operation.ADD, -amount)
	var spec = EffectSpec.new(effect)
	health_set.apply_effect(spec)
	
	if health_set.get_attribute("Health").current <= 0:
		death()

func death():
	queue_free()

#_ATTIBUTES_GETTERS______________#

func _get_speed() -> float:
	if not movement_set:
		return 0
	return movement_set.get_attribute("Speed").current

func _get_health() -> float:
	if not health_set:
		return 0
	return health_set.get_attribute("Health").current

func _get_max_health() -> float:
	if not health_set:
		return 0
	return health_set.get_attribute("MaxHealth").current
