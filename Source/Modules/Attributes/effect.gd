class_name Effect
extends Resource


@export_group("Duration")
@export var duration_policy: Global.Duration = Global.Duration.INSTANT
@export var duration: float = 0.0

@export_group("Period")
@export var period: float = 0.0

@export_group("Modifier")
@export var attribute: StringName
@export var modifier_op: Global.Operation = Global.Operation.ADD
@export var magnitude: float = 0.0

func _init(attribute: StringName, 
		modifier_op: Global.Operation = Global.Operation.ADD,
		magnitude: float = 0.0,
		duration_policy: Global.Duration = Global.Duration.INSTANT,
		duration: float = 0.0,
		period: float = 0.0):
	self.attribute = attribute
	self.modifier_op = modifier_op
	self.magnitude = magnitude
	self.duration_policy = duration_policy
	self.duration = duration
	self.period = period
	

func is_timed():
	return duration_policy == Global.Duration.HAS_DURATION

func is_periodic():
	return duration_policy != Global.Duration.INSTANT && period > 0.0

func is_temp():
	return duration_policy != Global.Duration.INSTANT && period == 0.0
