class_name EnemyBase
extends CharacterBase


@export var points_to_award := 0

var blood_particles = preload("res://Source/Particules/Blood/blood_particles.tscn")

func _physics_process(delta):
	super._physics_process(delta)
	if Global.player != null and !stunned:
		velocity = global_position.direction_to(Global.player.global_position)
	elif stunned:
		velocity = lerp(velocity, Vector2.ZERO, 0.3)
	global_position += velocity * speed * delta
	move_and_collide(velocity * delta)

func _get_direction() -> Vector2:
	return global_position.direction_to(Global.player_position)

func take_damage(amount: float):
	super.take_damage(amount)
	if !stunned:
		stunned = true
		velocity = -velocity * 1.2
		$Body/Sprite.modulate = Color("ff9494")
		$StaggerTimer.start()

func death():
	Global.points += points_to_award
	var new_blood_particle = blood_particles.instantiate()
	new_blood_particle.global_position = global_position
	new_blood_particle.rotation = -velocity.angle()
	get_parent().add_child(new_blood_particle)
	super.death()

func _on_stagger_timer_timeout() -> void:
	$Body/Sprite.modulate = Color.WHITE
	stunned = false
