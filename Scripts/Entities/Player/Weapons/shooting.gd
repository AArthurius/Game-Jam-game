extends Node

@onready var autocannon: Node2D = $"../Weapons/Autocannon"


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		autocannon.shoot()
