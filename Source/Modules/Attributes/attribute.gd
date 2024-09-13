class_name Attribute
extends RefCounted

signal base_changed(sender, prev)
signal current_changed(sender, prev)

var name: StringName
var base: float:
	get = _get_base,
	set = _set_base

var current: float:
	get = _get_current,
	set = _set_current

func _init(name: StringName, base: float) -> void:
	self.name = name
	self.base = base
	self.current = base

func _get_base() -> float:
	return base

func _set_base(value: float):
	if base != value:
		var prev := base
		base = value
		base_changed.emit(self, prev)

func _get_current() -> float:
	return current

func _set_current(value: float):
	if current != value:
		var prev := current
		current = value
		current_changed.emit(self, prev)

func modify(effect: Effect):
	match effect.modifier_op:
		Global.Operation.ADD:
			base += effect.magnitude
		Global.Operation.MULTIPLY:
			base *= effect.magnitude
		Global.Operation.DIVIDE:
			if effect.magnitude > 0:
				base /= effect.magnitude
		Global.Operation.OVERRIDE:
			base = effect.magnitude
