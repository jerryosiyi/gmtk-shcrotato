extends Control


func _ready() -> void:
	if Global.cleared:
		$Title.text = "Game Cleared"
	else:
		$Title.text = "Game Over"
	$Result/Score.text = var_to_str(Global.points)
	$Result/Wave/Value.text = var_to_str(Global.wave)

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Stages/Meadows/meadows.tscn")

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Source/UI/Menus/main_menu.tscn")
