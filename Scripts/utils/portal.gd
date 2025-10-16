extends Node2D

func _on_body_entered(_body: Node2D) -> void:
	
	if get_tree().current_scene.name == "Chapter1": 
		get_tree().current_scene.call_deferred("queue_free")
		get_tree().change_scene_to_file("res://Scenes/chapters/chapter_2.tscn")
	elif get_tree().current_scene.name == "Chapter2":
		get_tree().current_scene.call_deferred("queue_free")
		get_tree().change_scene_to_file("res://Scenes/chapters/chapter_1.tscn")
