class_name AttributeSet
extends Node

var attributes: Dictionary
var active_effects: Dictionary

func create_attribtue(name: StringName, base: float):
	var attribute: Attribute = Attribute.new(name, base)
	attribute.base_changed.connect(_on_attribute_base_changed)
	attribute.current_changed.connect(_on_attribute_current_changed)
	attributes[name] = attribute
	active_effects[name] = EffectSpecArray.new()

func has_attribute(name: StringName) -> bool:
	return attributes[name]

func get_attribute(name: StringName) -> Attribute:
	return attributes[name]

func apply_effect(spec: EffectSpec):
	var name = spec.effect.attribute
	if spec.effect.is_timed():
		add_child(spec.duration_timer)
		spec.duration_timer.connect("timeout", _on_duration_timeout.bind(spec))
	
	if spec.effect.is_periodic():
		add_child(spec.period_timer)
		spec.period_timer.connect("timeout", _on_period_timeout.bind(spec))
		active_effects[name].add(spec)
	else:
		if !spec.effect.is_temp(): # permanent -> mod base
			attributes[name].modify(spec.effect)
		else: # temp -> mod current
			attributes[name].current = modify_current(spec.effect, attributes[name].current)
			active_effects[name].add(spec)

func remove_effect(spec: EffectSpec):
	var name = spec.effect.attribute
	active_effects[name].erase(spec)
	if spec.effect.is_timed():
		spec.duration_timer.queue_free()
	if spec.effect.is_periodic():
		spec.period_timer.queue_free()
	else:
		recalculate_current(name)

func recalculate_current(attribute: StringName):
	var current: float = attributes[attribute].base
	for spec: EffectSpec in active_effects[attribute].iterate():
		current = modify_current(spec.effect, current)
	attributes[attribute].current = current

func modify_current(effect: Effect, current: float) -> float:
	match effect.modifier_op:
		Global.Operation.ADD:
			current += effect.magnitude
		Global.Operation.MULTIPLY:
			current *= effect.magnitude
		Global.Operation.DIVIDE:
			if effect.magnitude > 0:
				current /= effect.magnitude
		Global.Operation.OVERRIDE:
			current = effect.magnitude
	return current

func _on_attribute_base_changed(attribute: Attribute, prev: float):
	recalculate_current(attribute.name)

func _on_attribute_current_changed(attribute: Attribute, prev: float):
	pass

func _on_duration_timeout(spec: EffectSpec):
	remove_effect(spec)

func _on_period_timeout(spec: EffectSpec):
	var name = spec.effect.attribute
	attributes[name].modify(spec.effect)
