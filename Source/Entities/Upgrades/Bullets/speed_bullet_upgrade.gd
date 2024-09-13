class_name SpeedBulletUpgrade
extends BulletUpgradeBase


@export var modifier: Global.Operation = Global.Operation.ADD
@export var amount := 50.0

func apply_upgrade(_args):
	super.apply_upgrade(_args)
	match modifier:
		Global.Operation.ADD:
			bullet.speed += amount
		Global.Operation.MULTIPLY:
			bullet.speed *= amount
		Global.Operation.DIVIDE:
			if amount > 0:
				bullet.speed /= amount
		Global.Operation.OVERRIDE:
			bullet.speed = amount
