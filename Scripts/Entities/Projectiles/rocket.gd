extends CharacterBody2D

@export var max_speed = 400
@export var acc = 15000

var dir: Vector2
var spawn_pos: Vector2
var spawn_rot: float
var has_target:bool = false
var target: CharacterBody2D

func _ready() -> void:
	global_position = spawn_pos
	global_rotation = spawn_rot

func _process(delta: float) -> void:
	if target == null:
		has_target = false
		dir = ($Marker2D.global_position - global_position).normalized()
		look_at($Marker2D.global_position)
	if target != null:
		look_at(target.global_position)
		dir = (target.global_position - global_position).normalized()

func _physics_process(delta: float) -> void:
	handle_movement(delta)

func handle_movement(delta):
	var direction: Vector2
	direction += dir * acc * delta
	
	direction.x = clamp(direction.x, -max_speed, max_speed)
	direction.y = clamp(direction.y, -max_speed, max_speed)
	
	velocity = direction 
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("kill"):
		body.kill()
		queue_free()
	if body.is_in_group("boundary"):
		queue_free()

func _on_seeking_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy") and !has_target and !body.targeted:
		body.targeted = true
		has_target = true
		target = body

func _on_timer_timeout() -> void:
	queue_free()
