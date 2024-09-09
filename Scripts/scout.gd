extends CharacterBody2D

@onready var player:CharacterBody2D = %Player

const SPEED = 300.0


func _physics_process(delta: float) -> void:
	look_at(player.position)
