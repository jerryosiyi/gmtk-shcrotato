extends Node2D


@export var waves: Array[Wave]
@export var upgrades: Array[UpgradeBase]

var game_path = "res://Stages/Meadows/meadows.tscn"
var main_menu_path = "res://Source/UI/Menus/main_menu.tscn"

var current_wave: int = 1

func _ready() -> void:
	Global.game_over.connect(_on_game_over)
	Global.reset()
	$WaveTimer.wait_time = get_current_wave_duration()
	$WaveTimer.timeout.connect(_on_wave_timer_timeout)
	$WaveTimer.start()
	$SpawnTimer.wait_time = get_current_wave_spawn_time()
	$SpawnTimer.timeout.connect(_on_spawn_timer_timeout)
	$SpawnTimer.start()

func _process(delta: float) -> void:
	%HUD/MarginContainer/Counters/Health/Value.text = var_to_str(int(Global.player.health))
	%HUD/MarginContainer/Counters/Score.text = var_to_str(Global.points)
	%HUD/MarginContainer/WaveCounters/Wave/Value.text = var_to_str(current_wave)
	%HUD/MarginContainer/WaveCounters/Time.text = var_to_str(int($WaveTimer.time_left))

func get_current_wave_spawn_time() -> float:
	var wave := waves[current_wave-1]
	if wave:
		return wave.enemy_spawn_time
	return -1

func get_current_wave_duration() -> float:
	var wave := waves[current_wave-1]
	if wave:
		return wave.wave_duration
	return -1

func get_current_wave_enemy() -> PackedScene:
	var wave := waves[current_wave-1]
	if wave:
		return wave.enemy_weight_array.spawn_weighted_enemy()
	return null

func wait_until_wave_clear():
	# Check if the list of active enemies is empty
	var enemy := false
	for child in $Enemies.get_children():
		if child is EnemyBase:
			enemy = true
			break
	
	if !enemy:
		Global.cleared = true
		Global.wave = current_wave
		get_tree().change_scene_to_file("res://Source/UI/Menus/end_game.tscn")
	else:
		await get_tree().create_timer(0.5).timeout
		wait_until_wave_clear()

func wait_until_upgraded():
	if Global.upgraded:
		for child in $Boxes.get_children():
			if child is TheBox:
				child.hide()
				$Boxes.remove_child(child)
				child.queue_free()
		current_wave += 1
		Global.upgraded = false
		$SpawnTimer.paused = false
		$WaveTimer.wait_time = get_current_wave_duration()
		$WaveTimer.start()
		$SpawnTimer.wait_time = get_current_wave_spawn_time()
		$SpawnTimer.start()
		
	else:
		await get_tree().create_timer(0.5).timeout
		wait_until_upgraded()

func spawn_boxes():
	var chosen_upgrades: Array = []
	
	while chosen_upgrades.size() < 3:
		var random_upgrade = upgrades[randi() % upgrades.size()]
		if random_upgrade not in chosen_upgrades:
			chosen_upgrades.append(random_upgrade)
	
	for i in range(3):
		var new_box: TheBox = preload("res://Source/Entities/TheBox/the_box.tscn").instantiate()
		new_box.upgrade_to_grant = chosen_upgrades[i]
		$Boxes.add_child(new_box)
		new_box.global_position = $Boxes.get_child(i).global_position

func _on_wave_timer_timeout() -> void:
	$SpawnTimer.paused = true
	if current_wave == waves.size():
		wait_until_wave_clear()
	else:
		spawn_boxes()
		wait_until_upgraded()

func _on_spawn_timer_timeout() -> void:
	var new_enemy = get_current_wave_enemy().instantiate()
	$EnemySpawnPath/EnemySpawnFollow.progress_ratio = randf()
	new_enemy.global_position = $EnemySpawnPath/EnemySpawnFollow.global_position
	$Enemies.add_child(new_enemy)

func _on_game_over():
	Global.cleared = false
	Global.wave = current_wave
	get_tree().change_scene_to_file("res://Source/UI/Menus/end_game.tscn")
