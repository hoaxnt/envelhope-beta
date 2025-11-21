extends CanvasLayer

func _ready() -> void:
	hide()
	
func _on_bag_button_pressed() -> void:
	get_tree().current_scene.call_deferred("queue_free")
	get_tree().call_deferred("change_scene_to_file", "res://scenes/minigames/island/pearl_diving.tscn")
	print("bug")

func _on_view_quest_button_pressed() -> void:
	print("view quest")
