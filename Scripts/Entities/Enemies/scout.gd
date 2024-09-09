extends CharacterBody2D

@onready var player:CharacterBody2D = %Player
@onready var engine_effects: AnimatedSprite2D = $Sprites/engineEffects
@onready var hull: AnimatedSprite2D = $Sprites/hull

const SPEED = 300.0


func _process(delta: float) -> void:
	look_at(player.position)
	pass

func _physics_process(delta: float) -> void:
	var player_direction = (player.position - global_position).normalized()
	
	pass

func kill():
	engine_effects.play("off")
