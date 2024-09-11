extends Node2D

@onready var time_to_spawn: Timer = $"Environment/Spawner manager/Time to spawn"
@onready var enemies: Node2D = $Environment/Enemies
@onready var spawner_manager: Node2D = $"Environment/Spawner manager"

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
		spawner_manager.difficulty_level = 1
		time_to_spawn.wait_time = 4
	if score > 40 and score < 60:
		time_to_spawn.wait_time = 3
		spawner_manager.difficulty_level = 2
	if score > 60 and score < 100:
		time_to_spawn.wait_time = 2
		spawner_manager.difficulty_level = 3 
	if score > 100:
		time_to_spawn.wait_time = 1
		spawner_manager.difficulty_level = 4

func add_score(amount):
	update_score.emit(amount)
	score += amount
