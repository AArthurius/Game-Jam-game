extends CharacterBody2D

var broken = preload("res://Assets/Graphics/Ship/Hull/Hull - Broken.png")

@onready var engine: AnimatedSprite2D = $Sprites/BaseEngine/BaseEngineEffects
@onready var engine_effects: AnimatedSprite2D = $Sprites/BaseEngine/BaseEngineEffects
@onready var hull: Sprite2D = $Sprites/Hull
@onready var shields_sprites: AnimatedSprite2D = $Sprites/Shields
@onready var weapons_manager: Node2D = $Weapons


var max_speed = 300
var acc = 500
var input_dir: Vector2 = Vector2(0, 0)
var direction: Vector2 = Vector2(0, 0)
var dead:bool = false

var has_basic_shield:bool = false

func _process(delta: float) -> void:
	if dead:
		return
	
	
	input_dir = Input.get_vector("left","right","up", "down")
	look_at(get_global_mouse_position())
	
	if input_dir:
		engine.play("powering")
	else:
		engine.play("idle")
	
	shields_anim()

func _physics_process(delta: float) -> void:
	if dead:
		dead_movement()
		return
	
	if input_dir:
		direction += input_dir * acc * delta
	else:
		friction(delta)
	
	direction.x = clamp(direction.x, -max_speed, max_speed)
	direction.y = clamp(direction.y, -max_speed, max_speed)
	
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
	if has_basic_shield:
		has_basic_shield = false
		shields_sprites.play("no shield")
		return
	dead = true
	engine_effects.play("death")
	hull.texture = broken
	engine_effects.play("death")

func dead_movement():
	move_and_slide()

func pickup(pickup: String, type:String):
	if type == "shield":
		disable_shields()
		match pickup:
			"basic shield":
				has_basic_shield = true
	elif type == "weapon":
		match pickup:
			"autocannon":
				weapons_manager.weapon = 1
			"rockets":
				weapons_manager.weapon = 2

func shields_anim():
	if has_basic_shield:
		shields_sprites.play("basic shield")

func disable_shields():
	has_basic_shield = false
	shields_sprites.play("no shield")
