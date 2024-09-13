class_name SpeedPlayerUpgrade
extends PlayerUpgradeBase


@export var modifier: Global.Operation = Global.Operation.ADD
@export var amount := 50.0

func apply_upgrade(_args):
	super.apply_upgrade(_args)
	var effect: Effect = Effect.new("Speed", modifier, amount)
	var spec = EffectSpec.new(effect)
	player.movement_set.apply_effect(spec)
