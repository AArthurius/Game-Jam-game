extends Node2D

const CANNON_BULLET = preload("res://Scenes/Entities/Projectiles/player/cannon_bullet.tscn")

@onready var player: CharacterBody2D = $"../.."
@onready var cannon_1: AnimatedSprite2D = $Autocannon1
@onready var cannon_2: AnimatedSprite2D = $Autocannon2
@onready var barrel_1: Marker2D = $Autocannon1/Barrel1
@onready var barrel_2: Marker2D = $Autocannon2/Barrel2
@onready var timer: Timer = $Timer

var fired2:bool = false
var shoot_in_cd:bool = false
var can_shoot_1: bool = true
var can_shoot_2: bool = true
var dead:bool = false

signal spawn_bullet(pos, aim_direction, bullet_rotation)

func _process(delta: float) -> void:
	if player.dead == true:
		dead = true
		return

#maybe put a cooldown on the gun itself, so you can't shoot so fast, instead of tying it to animation
func shoot():
	if dead:
		return
	
	if shoot_in_cd:
		return
	
	if can_shoot_1 and !fired2:
		cannon_1.play("shooting")
		shooting(barrel_1.global_position)
		fired2 = true
		can_shoot_1 = false
		shoot_in_cd = true
		timer.start()
	elif can_shoot_2 and fired2:
		cannon_2.play("shooting")
		shooting(barrel_2.global_position)
		fired2 = false
		can_shoot_2 = false
		shoot_in_cd = true
		timer.start()

func shooting(barrel_pos: Vector2):
	var player_direction = (get_global_mouse_position() - global_position).normalized()
	var bullet = CANNON_BULLET.instantiate() as CharacterBody2D
	bullet.spawn_pos = barrel_pos
	bullet.spawn_rot = player.rotation
	bullet.dir = player_direction
	if get_tree().root.get_child(0).get_node("Environment") != null:
		get_tree().root.get_child(0).get_node("Environment").get_node("Projectiles").add_child(bullet)
	else:
		get_tree().root.get_child(0).add_child(bullet)

func _on_autocannon_1_animation_finished() -> void:
	cannon_1.play("idle")
	can_shoot_1 = true

func _on_autocannon_2_animation_finished() -> void:
	cannon_2.play("idle")
	can_shoot_2 = true

func _on_timer_timeout() -> void:
	shoot_in_cd = false
