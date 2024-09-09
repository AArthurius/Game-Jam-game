extends CharacterBody2D

@export var SPEED = 300

var dir: Vector2
var spawn_pos: Vector2
var spawn_rot: float

func _ready() -> void:
	global_position = spawn_pos
	global_rotation = spawn_rot

func _physics_process(delta: float) -> void:
	velocity = SPEED * dir
	move_and_slide()
