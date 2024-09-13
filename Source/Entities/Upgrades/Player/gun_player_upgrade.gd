class_name GunPlayerUpgrade
extends PlayerUpgradeBase


func apply_upgrade(_args):
	super.apply_upgrade(_args)
	player.gun_count += 1
