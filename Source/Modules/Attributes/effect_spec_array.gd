class_name EffectSpecArray
extends Resource


var _array: Array[EffectSpec] = []

func iterate() -> Array[EffectSpec]:
	return _array

func iterate_reverse() -> Array:
	return range(_array.size() -1, -1, -1)

func add(spec_to_add: EffectSpec):
	if spec_to_add:
		_array.append(spec_to_add)

func erase(spec_to_erase: EffectSpec):
	if spec_to_erase:
		_array.erase(spec_to_erase)

func is_empty() -> bool:
	return _array.is_empty()

func has(spec: EffectSpec) -> bool:
	return _array.has(spec)

func clear() -> void:
	_array.clear()
