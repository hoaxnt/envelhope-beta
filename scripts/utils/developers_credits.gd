extends Control


func _on_skip_button_pressed() -> void:
	Transition.transition_to_scene("res://scenes/utils/main_menu.tscn")
