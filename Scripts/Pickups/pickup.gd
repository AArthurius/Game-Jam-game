extends Area2D

@export var pickup:String
@export var type:String

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.pickup(pickup, type)
		queue_free()


func _on_timer_timeout() -> void:
	queue_free()
