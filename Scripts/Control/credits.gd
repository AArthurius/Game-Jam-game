extends Control

const MENU = preload("res://Scenes/Control/menu.tscn")

func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://Scenes/Control/menu.tscn"))
	
