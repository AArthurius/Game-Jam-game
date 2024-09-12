extends Control

@onready var enemy_number: Label = $"Enemy number"
@onready var score_label: Label = $"Score Label"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var restart_button: Button = $"Restart button"
@onready var quit_button: Button = $"Quit button"
@onready var ammo_label: Label = $"Ammo Label"

var player_dead:bool = false

var rocket_ammo:int
var total_score:int = 0
var enemies:int = 0

func _process(delta: float) -> void:
	if player_dead:
		restart_button.visible = true
		quit_button.visible = true
	
	if rocket_ammo > 0:
		ammo_label.visible = true
	else:
		ammo_label.visible = false
	
	ammo_label.text = "rockets: %d" % rocket_ammo
	enemy_number.text = "enemies: %d" % enemies

func update_score(score):
	total_score += score
	animation_player.play("score pop")
	score_label.text = "score: %d" % total_score

func _on_world_update_score(amount: Variant) -> void:
	update_score(amount)

func _on_world_enemy_amount(amount: Variant) -> void:
	enemies = amount

func _on_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_player_player_dead() -> void:
	player_dead = true

func _on_control_pressed() -> void:
	get_tree().quit()

func _on_player_rocket_ammo(ammo: Variant) -> void:
	rocket_ammo = ammo
