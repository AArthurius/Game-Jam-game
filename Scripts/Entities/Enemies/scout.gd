extends CharacterBody2D

@onready var player:CharacterBody2D = %Player
@onready var engine_effects: AnimatedSprite2D = $Sprites/engineEffects
@onready var hull: AnimatedSprite2D = $Sprites/hull

var dead:bool = false

const SPEED = 300.0


func _process(delta: float) -> void:
	if dead:
		return
	
	look_at(player.position)
	pass

func _physics_process(delta: float) -> void:
	if dead:
		velocity = Vector2(0, 0)
		return
	
	var player_direction = (player.position - global_position).normalized()
	
	velocity = player_direction * SPEED * delta
	move_and_slide()

func kill():
	dead = true
	engine_effects.play("off")
	hull.play("death")
	$Hurtbox/CollisionShape2D.disabled = true
	$Collision.disabled = true
	collision_layer = 0
	collision_mask = 0

func _on_hull_animation_finished() -> void:
	if $Sprites/hull.animation == "death":
		queue_free()
