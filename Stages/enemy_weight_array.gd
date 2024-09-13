class_name EnemyWeightArray
extends Resource


@export var array: Array[EnemyWeight] = []

func iterate() -> Array[EnemyWeight]:
	return array

func iterate_reverse() -> Array:
	return range(array.size() -1, -1, -1)

func spawn_weighted_enemy() -> PackedScene:
	# Calculate the total weight
	var total_weight: int = 0
	var random_value: int = 0
	for enemy in array:
		total_weight += enemy.weight
		random_value = randi() % total_weight
	
	# Iterate through the dictionary to determine which enemy to spawn
	var cumulative_weight: int = 0
	for enemy in array:
		cumulative_weight += enemy.weight
		if random_value < cumulative_weight:
			return enemy.scene  # This is the selected enemy scene
	
	# In case something goes wrong, return a default enemy or null
	return null

func is_empty() -> bool:
	return array.is_empty()

func clear() -> void:
	array.clear()
