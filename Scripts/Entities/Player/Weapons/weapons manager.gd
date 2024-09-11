extends Node2D

@onready var autocannon: Node2D = $Autocannon
@onready var autocannon_sprite_1: AnimatedSprite2D = $Autocannon/Autocannon1
@onready var autocannon_sprite_2: AnimatedSprite2D = $Autocannon/Autocannon2
@onready var rockets_sprites: AnimatedSprite2D = $"Rockets/Rockets sprites"
@onready var rockets: Node2D = $Rockets


#1 - autocannon, 2 - rockets
var weapon:int = 1

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		if weapon == 1:
			autocannon.shoot()
		if weapon == 2:
			rockets.shoot()
	weapon_sprites()

func weapon_sprites():
	if weapon == 1:
		autocannon_sprite_1.visible = true
		autocannon_sprite_2.visible = true
	else:
		autocannon_sprite_1.visible = false
		autocannon_sprite_2.visible = false
	
	if weapon == 2:
		rockets_sprites.visible = true
	else:
		rockets_sprites.visible = false
