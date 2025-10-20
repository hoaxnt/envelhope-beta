extends CanvasLayer

func _on_bag_button_pressed() -> void:
	SaveLoad.load_game()
	print("bug")

func _on_view_quest_button_pressed() -> void:
	print("view quest")
