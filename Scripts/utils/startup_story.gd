extends Control

func _on_skip_button_pressed() -> void:
	Transition.transition_to_scene("res://scenes/chapters/chapter_1.tscn")
	
