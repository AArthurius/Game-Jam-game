extends Node2D

@onready var time_to_spawn: Timer = $"Time to spawn"
@onready var player: CharacterBody2D = %Player
@onready var top: Area2D = $top
@onready var bottom: Area2D = $bottom
@onready var left: Area2D = $left
@onready var right: Area2D = $right

var top_available:bool = true
var bottom_available:bool = true
var left_available:bool = true
var right_available:bool = true


func _process(delta: float) -> void:
	if player in top.get_overlapping_bodies():
		top_available = false
	else:
		top_available = true
	if player in bottom.get_overlapping_bodies():
		bottom_available = false
	else:
		bottom_available = true
	if player in left.get_overlapping_bodies():
		left_available = false
	else:
		left_available = true
	if player in right.get_overlapping_bodies():
		right_available = false
	else:
		right_available = true

func _on_timer_to_spawn_timeout() -> void:
	spawn_scout()

func spawn_scout():
	var where_spawn:int = randi_range(1, 4)
	
