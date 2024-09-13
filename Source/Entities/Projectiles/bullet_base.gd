class_name BulletBase
extends Area2D


@export var speed := 1000.0
@export var damage := 5.0
@export var max_pierce := 1

var current_pierce_count := 0

var direction := Vector2.ZERO
var range := 1200.0
var travelled_distance := 0.0

func _physics_process(delta):
	position += direction * speed * delta
	travelled_distance += speed * delta
	
	if travelled_distance > range:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if !(area.is_in_group("Enemy")):
		return
	
	var target := area.get_parent().get_parent()
	target.take_damage(damage)
	
	current_pierce_count += 1
	if current_pierce_count >= max_pierce:
		queue_free()
