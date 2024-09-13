class_name PierceBulletUpgrade
extends BulletUpgradeBase


@export var modifier: Global.Operation = Global.Operation.ADD
@export var amount := 1

func apply_upgrade(_args):
	super.apply_upgrade(_args)
	match modifier:
		Global.Operation.ADD:
			bullet.max_pierce += amount
		Global.Operation.MULTIPLY:
			bullet.max_pierce *= amount
		Global.Operation.DIVIDE:
			if amount > 0:
				bullet.max_pierce /= amount
		Global.Operation.OVERRIDE:
			bullet.max_pierce = amount
