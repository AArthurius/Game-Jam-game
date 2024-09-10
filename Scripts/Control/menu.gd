extends Control

const WORLD = preload("res://Scenes/Environment/world.tscn")

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(WORLD)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
