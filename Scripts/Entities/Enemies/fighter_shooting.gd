extends Node

@onready var fighter: CharacterBody2D = $".."
@onready var timer: Timer = $Timer
@onready var hull: AnimatedSprite2D = $"../Sprites/hull"
@onready var barrel_1: Marker2D = $"../Bullet spawn"
@onready var barrel_2: Marker2D = $"../Bullet spawn2"
@onready var laser: AudioStreamPlayer2D = $"../Sounds/Laser"

const LASER_BULLET = preload("res://Scenes/Entities/Projectiles/enemies/laser_bullet.tscn")

var dead:bool = false
var can_shoot:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = randf_range(0.7, 1.3)

func _on_timer_timeout() -> void:
	if dead:
		return
	
	can_shoot = true
	shooting_anim()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fighter.dead:
		dead = true
		return
	
	if hull.animation == "shooting":
		if hull.get_frame() == 1:
			shoot(barrel_1)
			laser.play()
			can_shoot = false
		if hull.get_frame() == 5:
			shoot(barrel_2)
			laser.play()
			can_shoot = false

func shoot(bullet_spawn):
	if dead or !can_shoot:
		return
	
	var laser_bullet = LASER_BULLET.instantiate() as CharacterBody2D
	laser_bullet.spawn_pos = bullet_spawn.global_position
	laser_bullet.spawn_rot = fighter.rotation
	laser_bullet.dir = fighter.player_direction
	get_tree().root.get_child(0).get_node("Environment").get_node("Projectiles").add_child(laser_bullet)

func shooting_anim():
	if dead:
		return
	
	hull.play("shooting")

func _on_hull_animation_finished() -> void:
	if dead:
		return
	
	if hull.animation == "shooting":
		hull.play("idle")
