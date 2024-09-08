extends Node2D

@onready var cannon_1: AnimatedSprite2D = $Autocannon1
@onready var cannon_2: AnimatedSprite2D = $Autocannon2

var switch:bool = false

var can_shoot_1: bool = true
var can_shoot_2: bool = true

func shoot():
	if can_shoot_1 and !switch:
		cannon_1.play("shooting")
		switch = true
		can_shoot_1 = false
	elif can_shoot_2 and switch:
		cannon_2.play("shooting")
		switch = false
		can_shoot_2 = false



func _on_autocannon_1_animation_finished() -> void:
	cannon_1.play("idle")
	can_shoot_1 = true


func _on_autocannon_2_animation_finished() -> void:
	cannon_2.play("idle")
	can_shoot_2 = true
