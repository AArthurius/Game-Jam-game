extends Area2D

@onready var marker_2d_1: Marker2D = $Marker2D1
@onready var marker_2d_2: Marker2D = $Marker2D2
@onready var marker_2d_3: Marker2D = $Marker2D3
@onready var marker_2d_5: Marker2D = $Marker2D5
@onready var marker_2d_6: Marker2D = $Marker2D6

const SCOUT = preload("res://Scenes/Entities/Enemies/scout.tscn")
const FRIGATE = preload("res://Scenes/Entities/Enemies/frigate.tscn")
const FIGHTER = preload("res://Scenes/Entities/Enemies/fighter.tscn")

func spawn(enemy):
	var chosen_marker:int = randi_range(1, 5)
	var position: Vector2
	
	match chosen_marker:
		1:
			position = marker_2d_1.global_position
		2:
			position = marker_2d_1.global_position
		3:
			position = marker_2d_1.global_position
		4:
			position = marker_2d_1.global_position
		5:
			position = marker_2d_1.global_position
	
	match enemy:
		"scout":
			var scout = SCOUT.instantiate() as CharacterBody2D
			scout.position = position
			get_tree().root.get_child(0).get_node("Environment").get_node("Enemies").add_child(scout)
		"frigate":
			var frigate = FRIGATE.instantiate() as CharacterBody2D
			frigate.position = position
			get_tree().root.get_child(0).get_node("Environment").get_node("Enemies").add_child(frigate)
		"fighter":
			var figther = FIGHTER.instantiate() as CharacterBody2D
			figther.position = position
			get_tree().root.get_child(0).get_node("Environment").get_node("Enemies").add_child(figther)
