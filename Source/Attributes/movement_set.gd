extends AttributeSet

@export_group("Starting Values")
@export var starting_speed: float

var spec: EffectSpec

func _ready():
	create_attribtue("Speed", starting_speed)
