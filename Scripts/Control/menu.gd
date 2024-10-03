extends Control

const WORLD = preload("res://Scenes/Environment/world.tscn")
const CREDITS = preload("res://Scenes/Control/credits.tscn")

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(WORLD)

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_packed(CREDITS)
