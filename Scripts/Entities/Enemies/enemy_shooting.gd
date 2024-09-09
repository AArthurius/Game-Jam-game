extends Node

@onready var scout: CharacterBody2D = $".."
@onready var timer: Timer = $Timer
@onready var hull: AnimatedSprite2D = $"../Sprites/hull"
@onready var bullet_spawn: Marker2D = $"../Bullet spawn"

const ROUND_BULLET = preload("res://Scenes/Entities/Projectiles/enemies/round_bullet.tscn")

var dead:bool = false
var can_shoot:bool = false

func _on_timer_timeout() -> void:
	if dead:
		return
	
	can_shoot = true
	shooting_anim()

func _process(delta: float) -> void:
	if scout.dead:
		dead = true
		return
	
	
	if hull.animation == "shooting":
		if hull.get_frame() == 3:
			shoot()
			can_shoot = false

func shoot():
	if dead or !can_shoot:
		return
	
	var scout_bullet = ROUND_BULLET.instantiate() as CharacterBody2D
	scout_bullet.spawn_pos = bullet_spawn.global_position
	scout_bullet.spawn_rot = scout.rotation
	scout_bullet.dir = scout.player_direction
	get_tree().root.get_child(0).get_node("Projectiles").add_child(scout_bullet)

func shooting_anim():
	if dead:
		return
	
	hull.play("shooting")

func _on_hull_animation_finished() -> void:
	if dead:
		return
	
	if hull.animation == "shooting":
		hull.play("idle")
