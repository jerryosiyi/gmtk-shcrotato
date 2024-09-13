class_name Player
extends CharacterBase



@export var gun: PackedScene

var bullet_upgrades: Array[BulletUpgradeBase] = []

var gun_count: float:
	set = _set_gun_count

func _ready():
	Global.player = self
	gun_count = 1

func _physics_process(delta):
	super._physics_process(delta)
	var direction = Input.get_vector("move_left","move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_collide(velocity * delta)

func _set_gun_count(value):
	if gun_count != value:
		gun_count = value
		spawn_guns()

func spawn_guns():
	for i in range(gun_count):
		var new_gun = gun.instantiate()
		$Guns/Path/Follow.progress_ratio = float(i) / gun_count
		print($Guns/Path/Follow.progress_ratio)
		new_gun.global_position = $Guns/Path/Follow.position
		$Guns.add_child(new_gun)

func take_damage(amount: float):
	super.take_damage(amount)
	if !stunned:
		stunned = true
		$Body/Sprite.modulate = Color("ff9494")
		$StaggerTimer.start()

func death():
	Global.game_over.emit()
	super.death()

func _on_hurt_box_area_entered(area: Area2D) -> void:
	if !area.is_in_group("Enemy"):
		return
	take_damage(20)
	var enemy = area.get_parent().get_parent() as EnemyBase
	enemy.take_damage(enemy.max_health)

func _on_stagger_timer_timeout() -> void:
	$Body/Sprite.modulate = Color.WHITE
	stunned = false
