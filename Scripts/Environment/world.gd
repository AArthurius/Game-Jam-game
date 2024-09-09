extends Node2D

const CANNON_BULLET = preload("res://Scenes/Entities/Projectiles/player/cannon_bullet.tscn")

var score:int = 0

signal update_score(amount)

func _on_autocannon_spawn_bullet(pos: Variant, aim_direction: Variant, bullet_rotation) -> void:
	var bullet = CANNON_BULLET.instantiate() as CharacterBody2D
	bullet.spawn_pos = pos
	bullet.spawn_rot = bullet_rotation
	bullet.dir = aim_direction
	$Environment.add_child(bullet)

func add_score(amount):
	update_score.emit(amount)
