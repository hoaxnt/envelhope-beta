extends Control

func _on_start_button_pressed() -> void:
	Transition.transition_to_scene("res://scenes/utils/startup_story.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
