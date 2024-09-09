extends CharacterBody2D

var full_health = preload("res://Assets/Ship/Hull/Hull - Broken.png")
var slightly_damaged: CompressedTexture2D = preload("res://Assets/Ship/Hull/Hull - Slight Damage.png")
var very_damaged = preload("res://Assets/Ship/Hull/Hull - Very damage.png")
var broken = preload("res://Assets/Ship/Hull/Hull - Broken.png")

@onready var engine: AnimatedSprite2D = $Sprites/BaseEngine/BaseEngineEffects

const MAX_SPEED = 350

var acc = 300
var input_dir: Vector2 = Vector2(0, 0)
var direction: Vector2 = Vector2(0, 0)


func _process(delta: float) -> void:
	input_dir = Input.get_vector("left","right","up", "down")
	look_at(get_global_mouse_position())
	
	if velocity.length() != 0:
		engine.play("powering")
	else:
		engine.play("idle")

func _physics_process(delta: float) -> void:
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
