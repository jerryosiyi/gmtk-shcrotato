extends Node2D


@onready var v_box = $VBox
@onready var label = $VBox/Label
@onready var title = $VBox/UpgradeTitle
@onready var desc = $VBox/UpgradeDesc

const base_text = "[E] to "

var active_areas: Array[InteractionArea] = []
var can_interact: bool = true

func register_area(area: InteractionArea):
	active_areas.push_back(area)

func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)

func _process(delta: float) -> void:
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		label.text = base_text + active_areas[0].action_name
		title.text = active_areas[0].get_parent().upgrade_to_grant.name
		desc.text = active_areas[0].get_parent().upgrade_to_grant.description
		v_box.global_position = active_areas[0].global_position
		v_box.global_position.y -= 36
		v_box.global_position.x -= label.size.x / 2
		v_box.show()
	else:
		v_box.hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") && can_interact:
		print("INTERACT")
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			await active_areas[0].interact.call()
			can_interact = true

func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = Global.player.global_position.distance_to(area1.global_position)
	var area2_to_player = Global.player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player
