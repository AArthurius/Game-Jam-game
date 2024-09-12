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
var enemy_amount:int = 0
var last_spawned:int = 1
var difficulty_level:int = 0

func _process(delta: float) -> void:
	player_position()
	if enemy_amount < 4:
		spawn_enemy(choose_random_enemy())

func player_position():
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
	spawn_enemy(choose_random_enemy())

func spawn_enemy(enemy):
	var where_spawn:int = randi_range(1, 4)
	
	match where_spawn:
		1:
			if top_available and last_spawned != 1:
				top.spawn(enemy)
				last_spawned = 1
			else:
				spawn_enemy(enemy)
		2:
			if bottom_available and last_spawned != 2:
				bottom.spawn(enemy)
				last_spawned = 2
			else:
				spawn_enemy(enemy)
		3:
			if left_available and last_spawned != 3:
				left.spawn(enemy)
				last_spawned = 3
			else:
				spawn_enemy(enemy)
		4:
			if right_available and last_spawned != 4:
				right.spawn(enemy)
				last_spawned = 4
			else:
				spawn_enemy(enemy)

func _on_world_enemy_amount(amount: Variant) -> void:
	enemy_amount = amount

func choose_random_enemy():
	var enemies: Array = ["scout", "frigate", "fighter"]
	var number = randi_range(0, enemies.size() - 3 + difficulty_level)
	number = clamp(number, 0, 2)
	return enemies[number]
