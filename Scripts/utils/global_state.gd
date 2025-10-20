extends Node2D

const SAVE_PATH = "user://game_save.json"
var current_money = 98989898
var current_hp = 98

var pause_menu_scene = preload("res://scenes/utils/pause_menu.tscn")
var current_menu_instance = null

func save_game():
	var save_dict = {
		"money": current_money,
		"hp": current_hp
		}
	var json_string = JSON.stringify(save_dict, "\t")
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)

	if file:
		file.store_string(json_string)
		print("Game saved successfully!")
	else:
			print("Error: Could not open file for saving.")

func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file found.")
		return false

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var json_string = file.get_as_text()
		var parse_result = JSON.parse_string(json_string)

		if parse_result:
			var save_dict = parse_result
			current_money = save_dict.get("money", 0) 
			current_hp = save_dict.get("hp", 0)
			
			# Optionally load the scene
			var scene_path = save_dict.get("current_scene")

			if scene_path and scene_path != get_tree().current_scene.filename:
				print("Game loaded successfully!")
				return true
			else:
				print("Error: Could not parse JSON data.")
				return false
	else:
		print("Error: Could not open file for loading.")
		return false



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
