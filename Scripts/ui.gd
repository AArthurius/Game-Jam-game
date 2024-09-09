extends Control

@onready var score_label: Label = $"Score Label"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var total_score:int = 0

func update_score(score):
	total_score += score
	animation_player.play("score pop")
	score_label.text = "score: %d" % total_score

func _on_world_update_score(amount: Variant) -> void:
	update_score(amount)
