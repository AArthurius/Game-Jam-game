extends Node2D

const CANNON_BULLET = preload("res://Scenes/Entities/Projectiles/player/cannon_bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_autocannon_spawn_bullet(pos: Variant, aim_direction: Variant, bullet_rotation) -> void:
	var bullet = CANNON_BULLET.instantiate() as CharacterBody2D
	bullet.spawn_pos = pos
	bullet.spawn_rot = bullet_rotation
	bullet.dir = aim_direction
	$Projectiles.add_child(bullet)
