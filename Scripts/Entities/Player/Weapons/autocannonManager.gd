extends Node2D
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
	
	if Input.is_action_pressed("shoot"):
		shoot()

#maybe put a cooldown on the gun itself, so you can't shoot so fast, instead of tying it to animation
func shoot():
	if dead:
		return
	
	if shoot_in_cd:
		return
	
	var player_direction = (get_global_mouse_position() - global_position).normalized()
	if can_shoot_1 and !fired2:
		cannon_1.play("shooting")
		spawn_bullet.emit(barrel_1.global_position, player_direction, player.rotation)
		fired2 = true
		can_shoot_1 = false
		shoot_in_cd = true
		timer.start()
	elif can_shoot_2 and fired2:
		cannon_2.play("shooting")
		spawn_bullet.emit(barrel_2.global_position, player_direction, player.rotation)
		fired2 = false
		can_shoot_2 = false
		shoot_in_cd = true
		timer.start()

func _on_autocannon_1_animation_finished() -> void:
	cannon_1.play("idle")
	can_shoot_1 = true

func _on_autocannon_2_animation_finished() -> void:
	cannon_2.play("idle")
	can_shoot_2 = true

func _on_timer_timeout() -> void:
	shoot_in_cd = false
