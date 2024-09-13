class_name BulletUpgradeBase
extends UpgradeBase

var bullet: BulletBase

func apply_upgrade(_args):
	bullet = _args as BulletBase
	if !bullet:
		return
