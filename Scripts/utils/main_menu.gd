extends Control

func _on_start_button_pressed() -> void:
	get_tree().current_scene.call_deferred("queue_free")
	get_tree().call_deferred("change_scene_to_file", "res://scenes/utils/startup_story.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
