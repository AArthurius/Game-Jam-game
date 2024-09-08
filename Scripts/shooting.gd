extends Node

@onready var auto_cannon = $"../Weapons/Autocannon/Autocannon2"

var can_shoot: bool = true
var weapon


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		#shoot
		pass
