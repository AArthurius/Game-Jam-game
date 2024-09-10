extends CharacterBody2D

@onready var player = get_tree().current_scene.get_node("Player")
@onready var engine_effects: AnimatedSprite2D = $Sprites/engineEffects
@onready var hull: AnimatedSprite2D = $Sprites/hull
@onready var random_pickup: Node = $"Random Pickup"

var dead:bool = false
var player_direction: Vector2
var direction: Vector2

const ACC = 500
const MAX_SPEED = 150

func _process(delta: float) -> void:
	if dead:
		return
	
	look_at(player.position)
	player_direction = (player.position - global_position).normalized()

func _physics_process(delta: float) -> void:
	if dead:
		velocity = Vector2(0, 0)
		return
	
	handle_movement(delta)

func kill():
	if dead:
		return
	random_pickup.random_pickup()
	dead = true
	engine_effects.play("off")
	hull.play("death")
	collision_layer = 0
	collision_mask = 0
	get_tree().root.get_child(0).add_score(5)

func _on_hull_animation_finished() -> void:
	if $Sprites/hull.animation == "death":
		queue_free()

func handle_movement(delta: float) -> void:
	if player_direction:
		direction += player_direction * ACC * delta
	else:
		friction(delta)
	
	direction.x = clamp(direction.x, -MAX_SPEED, MAX_SPEED)
	direction.y = clamp(direction.y, -MAX_SPEED, MAX_SPEED)
	
	velocity = direction 
	move_and_slide()

func friction(delta):
	var friction_x: int = 0
	var friction_y: int = 0
	var vel_x: int = direction.x
	var vel_y: int = direction.y
	
	
	if direction.x > 0:
		friction_x = ACC * delta
		vel_x -= friction_x
		direction.x = max(vel_x, 0)
	if direction.x < 0:
		friction_x = ACC * delta
		vel_x += friction_x
		direction.x = min(vel_x, 0)
	
	if direction.y > 0:
		friction_y = ACC * delta
		vel_y -= friction_y
		direction.y = max(vel_y, 0)
	if direction.y < 0:
		friction_y = ACC * delta
		vel_y += friction_y
		direction.y = min(vel_y, 0)
