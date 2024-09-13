class_name GunBase
extends Area2D


@export var bullet: PackedScene

var default_direction: Vector2 = Vector2.RIGHT
var can_shoot := false

@onready var gun_shot = $GunShot

func _ready():
	%Timer.timeout.connect(_on_timer_timeout)

func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		can_shoot = true
		var target = enemies_in_range.front()
		var target_position = target.global_position
		var rotation_angle = %Pivot.global_position.angle_to_point(target_position)
		%Pivot.rotation = rotation_angle
	else:
		can_shoot = false

func shoot():
	var new_bullet = bullet.instantiate()
	add_child(new_bullet)
	new_bullet.global_position = %Muzzle.global_position
	new_bullet.global_rotation = %Muzzle.global_rotation
	new_bullet.direction = default_direction.rotated(%Muzzle.global_rotation)
	gun_shot.play()
	for upgrade: UpgradeBase in Global.player.bullet_upgrades:
		upgrade.apply_upgrade(new_bullet)

func _on_timer_timeout():
	if can_shoot:
		shoot()
