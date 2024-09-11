extends Node2D

@onready var rockets_sprites: AnimatedSprite2D = $"Rockets sprites"
@onready var marker_1: Marker2D = $"Rockets sprites/Marker2D1"
@onready var marker_2: Marker2D = $"Rockets sprites/Marker2D2"
@onready var marker_3: Marker2D = $"Rockets sprites/Marker2D3"
@onready var marker_4: Marker2D = $"Rockets sprites/Marker2D4"
@onready var marker_5: Marker2D = $"Rockets sprites/Marker2D5"
@onready var marker_6: Marker2D = $"Rockets sprites/Marker2D6"
@onready var player: CharacterBody2D = $"../.."
@onready var timer: Timer = $Timer

var launched_1:bool = false
var launched_2:bool = false
var launched_3:bool = false
var launched_4:bool = false
var launched_5:bool = false
var launched_6:bool = false

var shooting:bool = false

const ROCKET = preload("res://Scenes/Entities/Projectiles/player/rocket.tscn")

func _process(delta: float) -> void:
	if player.dead:
		return
	
	if shooting:
		if rockets_sprites.get_frame() == 2 and !launched_1:
			launched_1 = true
			shoot(marker_1.global_position)
		if rockets_sprites.get_frame() == 4 and !launched_2:
			launched_2 = true
			shoot(marker_2.global_position)
		if rockets_sprites.get_frame() == 6 and !launched_3:
			launched_3 = true
			shoot(marker_3.global_position)
		if rockets_sprites.get_frame() == 8 and !launched_4:
			launched_4 = true
			shoot(marker_4.global_position)
		if rockets_sprites.get_frame() == 10 and !launched_5:
			launched_5 = true
			shoot(marker_5.global_position)
		if rockets_sprites.get_frame() == 12 and !launched_6:
			launched_6 = true
			shoot(marker_6.global_position)
			timer.start()

func shoot(position: Vector2):
	if player.dead:
		return
	
	var player_direction = (get_global_mouse_position() - global_position).normalized()
	var rocket = ROCKET.instantiate() as CharacterBody2D
	rocket.spawn_pos = position
	rocket.spawn_rot = player.rotation
	rocket.dir = player_direction
	get_tree().root.get_child(0).get_node("Environment").get_node("Projectiles").add_child(rocket)

func _on_timer_timeout() -> void:
	launched_1 = false
	launched_2 = false
	launched_3 = false
	launched_4 = false
	launched_5 = false
	launched_6 = false
	rockets_sprites.play("idle")
