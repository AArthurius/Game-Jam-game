extends Control

@onready var enemy_number: Label = $"Enemy number"
@onready var score_label: Label = $"Score Label"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var front_shield_timer: Timer = $"Front shield timer"
@onready var front_shield_pb: TextureProgressBar = $"Front shield pb"

var time_percentage:float

var total_score:int = 0
var enemies:int = 0

func _process(delta: float) -> void:
	enemy_number.text = "enemies: %d" % enemies
	
	if front_shield_timer.get_time_left() > 0:
		time_percentage = (1 - front_shield_timer.get_time_left() / front_shield_timer.get_wait_time()) * 100
	front_shield_pb.value = time_percentage
	

func update_score(score):
	total_score += score
	animation_player.play("score pop")
	score_label.text = "score: %d" % total_score

func _on_world_update_score(amount: Variant) -> void:
	update_score(amount)

func _on_world_enemy_amount(amount: Variant) -> void:
	enemies = amount

func _on_player_front_shield_timer_ui() -> void:
	front_shield_pb.visible = true
	front_shield_timer.start()

func _on_front_shield_timer_timeout() -> void:
	front_shield_pb.visible = false
