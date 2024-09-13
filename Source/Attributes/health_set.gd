extends AttributeSet

@export_group("Starting Values")
@export var starting_health: float
@export var starting_max_health: float

var spec: EffectSpec

func _ready():
	create_attribtue("Health", starting_health)
	create_attribtue("MaxHealth", starting_max_health)

func _on_attribute_current_changed(attribute: Attribute, prev: float):
	if attribute.name == "Health":
		# Clmaping HEALTH
		var max = get_attribute("MaxHealth").current
		if attribute.current > max:
			attribute.current = max
