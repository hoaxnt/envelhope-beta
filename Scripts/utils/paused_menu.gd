extends Control

func _ready() -> void:
	pass # Replace with function body.


func _on_resume_button_pressed() -> void:
	pass # Replace with function body.


func _on_main_menu_button_pressed() -> void:
	get_tree().current_scene.call_deferred("queue_free")
	get_tree().call_deferred("change_scene_to_file", "res://scenes/utils/main_menu.tscn")
