extends Node

@onready var frigate: CharacterBody2D = $".."
@onready var timer: Timer = $Timer
@onready var hull: AnimatedSprite2D = $"../Sprites/hull"
@onready var bullet_spawn: Marker2D = $"../Bullet spawn"

const WAVE = preload("res://Scenes/Entities/Projectiles/enemies/wave.tscn")

var dead:bool = false
var can_shoot:bool = false

func _on_timer_timeout() -> void:
	if dead:
		return
	
	can_shoot = true
	shooting_anim()

func _process(delta: float) -> void:
	if frigate.dead:
		dead = true
		return
	
	if hull.animation == "shooting":
		if hull.get_frame() == 5:
			shoot()
			can_shoot = false

func shoot():
	if dead or !can_shoot:
		return
	
	var wave = WAVE.instantiate() as CharacterBody2D
	wave.spawn_pos = bullet_spawn.global_position
	wave.spawn_rot = frigate.rotation
	wave.dir = frigate.player_direction
	get_tree().root.get_child(0).get_node("Environment").get_node("Projectiles").add_child(wave)

func shooting_anim():
	if dead:
		return
	
	hull.play("shooting")

func _on_hull_animation_finished() -> void:
	if dead:
		return
	
	if hull.animation == "shooting":
		hull.play("idle")
