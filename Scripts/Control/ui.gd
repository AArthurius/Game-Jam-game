extends Control

@onready var enemy_number: Label = $"Enemy number"
@onready var score_label: Label = $"Score Label"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var total_score:int = 0
var enemies:int = 0

func _process(delta: float) -> void:
	enemy_number.text = "enemies: %d" % enemies

func update_score(score):
	total_score += score
	animation_player.play("score pop")
	score_label.text = "score: %d" % total_score

func _on_world_update_score(amount: Variant) -> void:
	update_score(amount)

func _on_world_enemy_amount(amount: Variant) -> void:
	enemies = amount
