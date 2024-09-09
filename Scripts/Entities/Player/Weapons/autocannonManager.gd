extends Node2D
@onready var player: CharacterBody2D = $"../.."

@onready var cannon_1: AnimatedSprite2D = $Autocannon1
@onready var cannon_2: AnimatedSprite2D = $Autocannon2
@onready var barrel_1: Marker2D = $Autocannon1/Barrel1
@onready var barrel_2: Marker2D = $Autocannon2/Barrel2

var switch:bool = false

var can_shoot_1: bool = true
var can_shoot_2: bool = true

signal spawn_bullet(pos, aim_direction, bullet_rotation)


#maybe put a cooldown on the gun itself, so you can't shoot so fast, instead of tying it to animation
func shoot():
	var player_direction = (get_global_mouse_position() - global_position).normalized()
	
	if can_shoot_1 and !switch:
		cannon_1.play("shooting")
		spawn_bullet.emit(barrel_1.global_position, player_direction, player.rotation)
		switch = true
		can_shoot_1 = false
	elif can_shoot_2 and switch:
		cannon_2.play("shooting")
		spawn_bullet.emit(barrel_2.global_position, player_direction, player.rotation)
		switch = false
		can_shoot_2 = false

func _on_autocannon_1_animation_finished() -> void:
	cannon_1.play("idle")
	can_shoot_1 = true

func _on_autocannon_2_animation_finished() -> void:
	cannon_2.play("idle")
	can_shoot_2 = true
