class_name DamageBulletUpgrade
extends BulletUpgradeBase

@export var modifier: Global.Operation = Global.Operation.ADD
@export var amount := 5.0

func apply_upgrade(_args):
	super.apply_upgrade(_args)
	match modifier:
		Global.Operation.ADD:
			bullet.damage += amount
		Global.Operation.MULTIPLY:
			bullet.damage *= amount
		Global.Operation.DIVIDE:
			if amount > 0:
				bullet.damage /= amount
		Global.Operation.OVERRIDE:
			bullet.damage = amount
