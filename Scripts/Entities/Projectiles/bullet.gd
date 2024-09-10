extends CharacterBody2D

@export var SPEED = 20000

var dir: Vector2
var spawn_pos: Vector2
var spawn_rot: float

func _ready() -> void:
	global_position = spawn_pos
	global_rotation = spawn_rot

func _physics_process(delta: float) -> void:
	velocity = SPEED * dir * delta
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("kill"):
		body.kill()
		queue_free()
	if body.is_in_group("boundary"):
		queue_free()
