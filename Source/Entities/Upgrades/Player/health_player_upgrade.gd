class_name HealthPlayerUpgrade
extends PlayerUpgradeBase


@export var modifier: Global.Operation = Global.Operation.ADD
@export var amount := 50.0

func apply_upgrade(_args):
	super.apply_upgrade(_args)
	var effect: Effect = Effect.new("MaxHealth", modifier, amount)
	var spec = EffectSpec.new(effect)
	player.health_set.apply_effect(spec)
