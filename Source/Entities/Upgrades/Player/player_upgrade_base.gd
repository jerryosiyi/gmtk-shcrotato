class_name PlayerUpgradeBase
extends UpgradeBase

var player: Player

func apply_upgrade(_args):
	player = _args as Player
	if !player:
		return
