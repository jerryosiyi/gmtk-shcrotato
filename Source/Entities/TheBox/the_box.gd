class_name TheBox
extends Node2D


var upgrade_to_grant: UpgradeBase

@onready var interaction_area: InteractionArea = $InteractionArea

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	if upgrade_to_grant as BulletUpgradeBase:
		Global.player.bullet_upgrades.append(upgrade_to_grant)
		print(Global.player.bullet_upgrades.size())
	elif upgrade_to_grant as PlayerUpgradeBase:
		upgrade_to_grant.apply_upgrade(Global.player)
	Global.upgraded = true
