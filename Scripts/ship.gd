extends CharacterBody2D

var full_health = preload("res://Assets/Hull/Hull - Full Health.png")
var slightly_damaged: CompressedTexture2D = preload("res://Assets/Hull/Hull - Slight Damage.png")
var very_damaged = preload("res://Assets/Hull/Hull - Very damage.png")
var broken = preload("res://Assets/Hull/Hull - Broken.png")

@onready var sprite: Sprite2D = $Hull

var desired_dir := Vector2(0,0)
var dir := Vector2(0,0)
var current_speed: int = 0
var acc:int = 200

const MAX_SPEED: int = 200

func _ready() -> void:
	#sprite.set_texture(slightly_damaged)
	pass

func _process(delta: float) -> void:
	desired_dir = Input.get_vector("left", "right", "up", "down")
	look_at(get_global_mouse_position())

func _physics_process(delta: float) -> void:
	movement(delta)

func movement(delta):
	velocity = desired_dir * MAX_SPEED
	
	move_and_slide()
