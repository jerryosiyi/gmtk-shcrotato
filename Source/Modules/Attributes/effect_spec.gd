class_name EffectSpec
extends RefCounted


var effect: Effect
var period_timer: Timer
var duration_timer: Timer

func _init(effect: Effect) -> void:
	self.effect = effect
	if effect.is_timed():
		duration_timer = Timer.new()
		duration_timer.set_wait_time(effect.duration)
		duration_timer.set_one_shot(true)
		duration_timer.set_autostart(true)
	
	if effect.is_periodic():
		period_timer = Timer.new()
		period_timer.set_wait_time(effect.period)
		period_timer.set_one_shot(false)
		period_timer.set_autostart(true)

func get_modified_value() -> Array:
	if effect.modifier_op == Global.Operation.OVERRIDE:
		return [true, effect.magnitude]
	return  [false, effect.magnitude]
