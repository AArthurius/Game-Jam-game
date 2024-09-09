extends CharacterBody2D

var broken = preload("res://Assets/Graphics/Ship/Hull/Hull - Broken.png")

@onready var engine: AnimatedSprite2D = $Sprites/BaseEngine/BaseEngineEffects
@onready var engine_effects: AnimatedSprite2D = $Sprites/BaseEngine/BaseEngineEffects
@onready var hull: Sprite2D = $Sprites/Hull

const MAX_SPEED = 300
var acc = 350

var input_dir: Vector2 = Vector2(0, 0)
var direction: Vector2 = Vector2(0, 0)
var dead:bool = false

func _process(delta: float) -> void:
	if dead:
		return
	
	input_dir = Input.get_vector("left","right","up", "down")
	look_at(get_global_mouse_position())
	
	if input_dir:
		engine.play("powering")
	else:
		engine.play("idle")

func _physics_process(delta: float) -> void:
	if dead:
		dead_movement()
		return
	
	if input_dir:
		direction += input_dir * acc * delta
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
		friction_x = acc * delta
		vel_x -= friction_x
		direction.x = max(vel_x, 0)
	if direction.x < 0:
		friction_x = acc * delta
		vel_x += friction_x
		direction.x = min(vel_x, 0)
	
	if direction.y > 0:
		friction_y = acc * delta
		vel_y -= friction_y
		direction.y = max(vel_y, 0)
	if direction.y < 0:
		friction_y = acc * delta
		vel_y += friction_y
		direction.y = min(vel_y, 0)

func kill():
	dead = true
	engine_effects.play("death")
	hull.texture = broken
	engine_effects.play("death")

func dead_movement():
	move_and_slide()
