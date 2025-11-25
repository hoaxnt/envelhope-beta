extends Node2D

var pause_menu_scene = preload("res://scenes/utils/pause_menu.tscn")
var current_menu_instance = null

func toggle_pause() -> void:
		if get_tree().paused:
				unpause_game()
		else:
				pause_game()

func pause_game() -> void:
		if get_tree().paused: return
		get_tree().paused = true
		
		current_menu_instance = pause_menu_scene.instantiate()
		get_tree().root.add_child(current_menu_instance) 
		
func unpause_game() -> void:
		if not get_tree().paused: return 
		get_tree().paused = false
		
		if is_instance_valid(current_menu_instance):
				current_menu_instance.queue_free()
				current_menu_instance = null
