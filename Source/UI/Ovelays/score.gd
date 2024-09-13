extends Label

func _process(delta: float) -> void:
	text = var_to_str(Global.points)
