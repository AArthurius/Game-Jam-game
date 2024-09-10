extends Node2D

@onready var time_to_spawn: Timer = $"Environment/Spawner manager/Time to spawn"
@onready var enemies: Node2D = $Environment/Enemies

var score:int = 0
var enemy_number:int = 0

signal update_score(amount)
signal enemy_amount(amount)

func _process(delta: float) -> void:
	enemy_number = enemies.get_children().size()
	enemy_amount.emit(enemy_number)
	difficulty()

func difficulty():
	if score > 20 and score < 40:
		time_to_spawn.wait_time = 4
	if score > 40 and score < 60:
		time_to_spawn.wait_time = 3
	if score > 60 and score < 100:
		time_to_spawn.wait_time = 3
	if score > 100:
		time_to_spawn.wait_time = 1

func add_score(amount):
	update_score.emit(amount)
	score += amount
